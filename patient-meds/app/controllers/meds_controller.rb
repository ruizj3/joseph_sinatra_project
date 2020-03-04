class MedsController < ApplicationController
  get '/meds' do
    if logged_in?
      @meds = Meds.all
      erb :'meds/tweets'
    else
      redirect to '/login'
    end
  end

  get '/meds/new' do
    if logged_in?
      erb :'meds/create_meds'
    else
      redirect to '/login'
    end
  end

  post '/meds' do
    if logged_in?
      if params[:content] == ""
        redirect to "/meds/new"
      else
        @med = current_user.tweets.build(content: params[:content])
        if @med.save
          redirect to "/meds/#{@med.id}"
        else
          redirect to "/meds/new"
        end
      end
    else
      redirect to '/login'
    end
  end

  get '/meds/:id' do
    if logged_in?
      @med = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Meds.find_by_id(params[:id])
      if @med && @med.user == current_user
        erb :'meds/edit_tweet'
      else
        redirect to '/meds'
      end
    else
      redirect to '/login'
    end
  end

  patch '/meds/:id' do
    if logged_in?
      if params[:content] == ""
        redirect to "/meds/#{params[:id]}/edit"
      else
        @med = Meds.find_by_id(params[:id])
        if @med && @med.user == current_user
          if @med.update(content: params[:content])
            redirect to "/meds/#{@tweet.id}"
          else
            redirect to "/tweets/#{@tweet.id}/edit"
          end
        else
          redirect to '/tweets'
        end
      end
    else
      redirect to '/login'
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        @tweet.delete
      end
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end
end
