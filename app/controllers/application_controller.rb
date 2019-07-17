
require_relative '../../config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
#Step 1 - renders the page that shows a form for a new article
  get '/articles/new' do
    erb :new
  end
#Step 2 - Takes the input from the form and then renders it for viewing to the erb show.erb. I.e. preps the information to be presented.
#redirects to the page which the ID is assigned to
  post '/articles' do
    @article = Article.create(title: params["title"], content: params["content"])  
    # binding.pry
      redirect :"/articles/#{@article.id}"
  end

  #index page shows all of the articles
  get '/articles' do
    @articles  = Article.all
    erb :index
  end

  #get the id for the article being searched, assign it to an id, and use activerecord to find this INSTANCE
  get '/articles/:id' do
    id = params[:id]
    @article = Article.find(id)
    erb :show
  end

  #Need to retrieve the instance we want to edit. and Display all this information
  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end
#update this particular instance with the new information = need to retrieve existing infroamtion, and then assign title and content and SAVE
#after saving, redirect user to the homepage
  patch '/articles/:id' do
    @article = Article.find(params[:id])
    @article.title = params[:title]
    @article.content = params[:content]
    @article.save
    redirect :"/articles/#{@article.id}"
  end
#delete does not need a button , but this is the action of finding the instance and deleting in the database. The actual button is sitting in edit,
  delete '/articles/:id/delete' do
    article = Article.find(params[:id])
    article.destroy
    redirect to '/articles'
  end


end
