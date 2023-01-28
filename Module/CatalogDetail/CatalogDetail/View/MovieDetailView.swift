//
//  MovieDetailView.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 05/01/23.
//

import SwiftUI
import SDWebImageSwiftUI
import Lottie

public struct MovieDetailView: View {
    @ObservedObject var presenter: DetailPresenter
    @ObservedObject var favoritePresenter: FavoritePresenter
    var isMovie: Bool = false
    var animationView: LottieAnimationView?
    @State var isfav: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView{
                if presenter.loadingState {
                    LottieView(file: "loading")
                        .frame(width: 300, height: 300)
                        .tag(102)
                } else {
                    if isMovie {
                        WebImage(url: URL(string: presenter.movieDetail?.posterImage ?? "" ))
                            .resizable()
                            .placeholder(Image("NoImage"))
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .frame(height: 300)
                        VStack(alignment: .leading, spacing: 8){
                            Text(presenter.movieDetail?.title ?? "Title")
                                .getCustomFont(type: .bold, size: 32)
                                .foregroundColor(Color.white)
                            Text("Start Airing: \(presenter.movieDetail?.firstAiring ?? "n/a")")
                                .getCustomFont(type: .regular, size: 14)
                                .foregroundColor(Color.white)
                            Text("Synopsis")
                                .getCustomFont(type: .bold, size: 16)
                                .foregroundColor(Color.white)
                            Text(presenter.movieDetail?.desc ?? "No Detail")
                                .getCustomFont(type: .medium, size: 16)
                                .foregroundColor(Color.white)
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                            
                        Spacer()
                        self.printLog("Detail: \(presenter.movieDetail)")
                    } else {
                        WebImage(url: URL(string: presenter.tvDetail?.posterImage ?? "" ))
                            .resizable()
                            .placeholder(Image("NoImage"))
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .frame(height: 300)
                        VStack(alignment: .leading, spacing: 8){
                            Text(presenter.tvDetail?.title ?? "Title")
                                .getCustomFont(type: .bold, size: 32)
                                .foregroundColor(Color.white)
                            Text("Start Airing: \(presenter.tvDetail?.firstAiring ?? "n/a")")
                                .getCustomFont(type: .regular, size: 14)
                                .foregroundColor(Color.white)
                            Text("Synopsis")
                                .getCustomFont(type: .bold, size: 16)
                                .foregroundColor(Color.white)
                            if presenter.tvDetail?.desc == "" {
                                Text("No Detail provided")
                                    .foregroundColor(Color.white)
                                    .getCustomFont(type: .medium, size: 16)
                            } else {
                                Text(presenter.tvDetail?.desc ?? "No Detail")
                                    .foregroundColor(Color.white)
                                    .getCustomFont(type: .medium, size: 16)
                            }
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        self.printLog("Detail: \(presenter.tvDetail)")
                    }
                }
            }
            .modifier(CustomNavigationView())
            .navigationTitle(presenter.movieDetail?.title ?? presenter.tvDetail?.title ?? "Detail")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(false)
            .toolbar(content: {
                Button(action: {
                    if isMovie {
                        favoritePresenter.addMovieFavorite{
                            self.isfav = !self.isfav
                        }
                    } else {
                        favoritePresenter.tvDetail = presenter.tvDetail
                        favoritePresenter.addTVFavorite {
                            self.isfav = !self.isfav
                        }
                    }
                }) {
                    if self.isfav {
                        Image(systemName: "star.fill")
                    } else {
                        Image(systemName: "star")
                    }
                }
            })
        }
        .onAppear{
            self.presenter.isMovie = self.isMovie
            if self.presenter.isMovie {
                print("id: \(self.presenter.selectedID)")
                self.presenter.getMovie(id: self.presenter.movieDetail?.id ?? 0)
                self.favoritePresenter.getMovie(id: self.presenter.movieDetail?.id ?? 0)
                self.isfav = presenter.movieDetail?.isFavorite ?? false
            } else {
                print("id: \(self.presenter.selectedID)")
                self.presenter.getTv(id: self.presenter.tvDetail?.id ?? 0)
                self.favoritePresenter.getTv(id: self.presenter.tvDetail?.id ?? 0)
                self.isfav = presenter.tvDetail?.isFavorite ?? false
            }
        }
        .toolbar(.hidden, for: .tabBar)  
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let detailUseCase = Injection().provideDetailItem()
        let favoriteUseCase = Injection().provideFavorite()
        let presenter = DetailPresenter(useCase: detailUseCase, isMovie: false, selectedID: 40)
        let favoritePresenter = FavoritePresenter(useCase: favoriteUseCase)
        MovieDetailView(presenter: presenter, favoritePresenter: favoritePresenter, isMovie: true)
    }
}
