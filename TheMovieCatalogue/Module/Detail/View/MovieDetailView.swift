//
//  MovieDetailView.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 05/01/23.
//

import SwiftUI
import SDWebImageSwiftUI
import Lottie

struct MovieDetailView: View {
    @ObservedObject var presenter: DetailPresenter
    var isMovie: Bool = false
    var animationView: LottieAnimationView?
    
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
                            Text("Start Airing: \(presenter.movieDetail?.firstAiring ?? "n/a")")
                                .getCustomFont(type: .regular, size: 14)
                            Text("Synopsis")
                                .getCustomFont(type: .bold, size: 16)
                            Text(presenter.movieDetail?.desc ?? "No Detail")
                                .getCustomFont(type: .medium, size: 16)
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
                            Text("Start Airing: \(presenter.tvDetail?.firstAiring ?? "n/a")")
                                .getCustomFont(type: .regular, size: 14)
                            Text("Synopsis")
                                .getCustomFont(type: .bold, size: 16)
                            if presenter.tvDetail?.desc == "" {
                                Text("No Detail provided")
                                    .getCustomFont(type: .medium, size: 16)
                            } else {
                                Text(presenter.tvDetail?.desc ?? "No Detail")
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
        }
        .onAppear{
            self.presenter.isMovie = self.isMovie
            if self.presenter.isMovie {
                print("id: \(self.presenter.selectedID)")
                self.presenter.getMovie(id: self.presenter.movieDetail?.id ?? 0)
            } else {
                print("id: \(self.presenter.selectedID)")
                self.presenter.getTv(id: self.presenter.tvDetail?.id ?? 0)
            }
        }
        .toolbar(.hidden, for: .tabBar)  
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let detailUseCase = Injection().provideDetailItem()
        let detailPresenter = DetailPresenter(useCase: detailUseCase, isMovie: true)
        MovieDetailView(presenter: detailPresenter, isMovie: true)
    }
}
