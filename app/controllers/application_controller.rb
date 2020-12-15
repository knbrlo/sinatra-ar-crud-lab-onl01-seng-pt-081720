
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get '/articles' do
    @articles = Article.all

    erb :index
  end

  get '/articles/new' do
    erb :new
  end

  post '/articles' do
    @article = Article.create(params)

    redirect to "/articles/#{@article[:id]}"
  end

  get '/articles/:id' do
    article_id = params[:id].to_i
    @article = Article.find(article_id)

    erb :show
  end

  get '/articles/:id/edit' do
    article_id = params[:id].to_i

    # find the article
    @article = Article.find(article_id)

    erb :edit
  end

  patch '/articles/:id' do
    @new_params = params

    @article = Article.find(params[:id])
    @article.title = params[:title].strip
    @article.content = params[:content].strip
    @article.save

    redirect to "/articles/#{params[:id]}"
  end

  delete '/articles/:id' do
    article_id = params[:id].to_i

    @article = Article.find(article_id)
    @article.delete
    
    binding.pry

    redirect to "/articles"
  end

end
