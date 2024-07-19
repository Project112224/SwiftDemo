//
//  HomeViewModel.swift
//  iOSInterviewV1
//
//  Created by june on 2024/7/10.
//

import Foundation
import Combine

class HomeViewModel {
    
    // .usdSavings1, .usdFixed1, .usdDigital1, .khrSavings1, .khrFixed1, .khrDigital1]
    private let firstOpenAmountApiList: [Endpoint] = [.usdSavings1, .khrSavings1]
    
    // .usdSavings2, .usdFixed2, .usdFixed2, .usdDigital2, .khrSavings2, .khrFixed2, .khrDigital2]
    private let pullRefreshAmountApiList: [Endpoint] = [.usdSavings2, .khrSavings2]

    private var isFirstLoad: Bool = true
    
    private var notificationData: [NotificationMessageModel] = []
    
    struct Input {
        let refreshAction: CustomSubject<Void>
        let notificationAction: CustomSubject<Void>
    }
    
    struct Output {
        let notificationActionResponse: CustomSubject<[NotificationMessageModel]>
        let notificationResponse: CustomSubject<Bool>
        let accountResponse: CustomSubject<HomeAccountBindModel>
        let favoriteResponse: CustomSubject<[HomeFavoriteInfoModel]>
        let bannerResponse: CustomSubject<[HomeAdBannerInfoModel]>
        let refreshResponse: CustomSubject<Bool>
        let errorResponse: CustomSubject<String>
    }

    func transfer(input: Input) -> Output {
        let notificationActionResponse = CustomSubject<[NotificationMessageModel]>()
        input.notificationAction.subscribe { [weak self] _ in
            guard let `self` = self else { return }
            notificationActionResponse.send(self.notificationData)
        }
        
        let errorResponse = CustomSubject<String>()
        
        let notificationResponse = CustomSubject<Bool>()
        Task {
            await self.fetchNotificationList(onNext: { [weak self] list in
                guard let `self` = self else { return }
                self.notificationData = list
                notificationResponse.send(list.isEmpty)
            }, onError: { message in
                errorResponse.send(message)
            })
        }
        
        let accountResponse = CustomSubject<HomeAccountBindModel>()
        Task {
            await self.fetchAccount(apiList: self.firstOpenAmountApiList, onNext: { [weak self] list in
                guard let `self` = self else { return }
                let calculate = self.calculateBalance(list)
                accountResponse.send(calculate)
            }, onError: { message in
                errorResponse.send(message)
            })
        }
        
        let favoriteResponse = CustomSubject<[HomeFavoriteInfoModel]>()
        Task {
            await self.fetchFavorite(
                onNext: { favoriteResponse.send($0?.favoriteList ?? []) },
                onError: { message in
                    errorResponse.send(message)
                })
        }
        
        let bannerResponse = CustomSubject<[HomeAdBannerInfoModel]>()
        Task {
            await self.fetchAdBanner(
                onNext: { bannerResponse.send($0) },
                onError: { message in
                    errorResponse.send(message)
                })
        }
        
        let refreshResponse = CustomSubject<Bool>()
        input.refreshAction.subscribe { [weak self] _ in
            guard let `self` = self else { return }
            self.isFirstLoad = false
            Task {
                await self.fetchNotificationList(onNext: { [weak self] list in
                    guard let `self` = self else { return }
                    self.notificationData = list
                    notificationResponse.send(list.isEmpty)
                }, onError: { message in
                    errorResponse.send(message)
                })
                await self.fetchAccount(apiList: self.pullRefreshAmountApiList, onNext: { [weak self] list in
                    guard let `self` = self else { return }
                    let calculate = self.calculateBalance(list)
                    accountResponse.send(calculate)
                }, onError: { message in
                    errorResponse.send(message)
                })
                await self.fetchFavorite(
                    onNext: { favoriteResponse.send($0?.favoriteList ?? []) },
                    onError: { message in
                        errorResponse.send(message)
                    })
                await self.fetchAdBanner(
                    onNext: { bannerResponse.send($0) },
                    onError: { message in
                        errorResponse.send(message)
                    })
            }
            refreshResponse.send(true)
        }
        
        let output = Output(
            notificationActionResponse: notificationActionResponse,
            notificationResponse: notificationResponse,
            accountResponse: accountResponse,
            favoriteResponse: favoriteResponse,
            bannerResponse: bannerResponse,
            refreshResponse: refreshResponse,
            errorResponse: errorResponse
        )
        
        return output
    }
}

extension HomeViewModel {
    
    private func calculateBalance(_ list: [HomeAccountBalanceModel?]) -> HomeAccountBindModel {
        var model = HomeAccountBalanceModel(savingsList: [], fixedDepositList: [], digitalList: [])
        for item in list {
            model.digitalList! += item?.digitalList ?? []
            model.fixedDepositList! += item?.fixedDepositList ?? []
            model.savingsList! += item?.savingsList ?? []
        }
        let list: [HomeAccountBalanceInfoModel] = (model.digitalList ?? []) + (model.fixedDepositList ?? []) + (model.savingsList ?? [])
        return self.calculateFromCurrency(list: list)
    }

    private func calculateFromCurrency(list: [HomeAccountBalanceInfoModel]) -> HomeAccountBindModel {
        var usd: Decimal = 0.0
        var khr: Decimal = 0.0
        for item in list {
            if (item.curr == CurrencyType.usd.rawValue) {
                usd += item.balance
            } else {
                khr += item.balance
            }
        }
        
        return HomeAccountBindModel(
            usd: HomeCurrcyBalanceModel(curr: .usd, balance: usd),
            khr: HomeCurrcyBalanceModel(curr: .khr, balance: khr)
        )
    }
}

// MARK: - Fetch API
extension HomeViewModel {
    
    private func fetchNotificationList(onNext: ([NotificationMessageModel])->(), onError: @escaping (String)->()) async {
        if (self.isFirstLoad) {
            await NotificationService.emptyList { list in
                onNext(list ?? [])
            } onError: { error in
                onError(error.localizedDescription)
            }
            return
        }
        await NotificationService.queryList { list in
            onNext(list ?? [])
        } onError: { error in
            onError(error.localizedDescription)
        }
    }
    
    private func fetchAccount(apiList: [Endpoint], onNext: ([HomeAccountBalanceModel?])->(), onError: @escaping (String)->()) async {
        await AccountService.queryBalance(apiList: apiList) { list in
            onNext(list)
        } onError: { error in
            onError(error.localizedDescription)
        }
    }
    
    private func fetchFavorite(onNext: (HomeFavoriteModel?)->(), onError: @escaping (String)->()) async {
        if (self.isFirstLoad) {
            await FavoriteService.emptyList { model in
                onNext(model)
            } onError: { error in
                onError(error.localizedDescription)
            }
            return
        }
        await FavoriteService.queryList { model in
            onNext(model)
        } onError: { error in
            onError(error.localizedDescription)
        }
    }
    
    private func fetchAdBanner(onNext: ([HomeAdBannerInfoModel])->(), onError: @escaping (String)->()) async {
        await BannerService.queryList { list in
            onNext(list)
        } onError: { error in
            onError(error.localizedDescription)
        }

    }
}
