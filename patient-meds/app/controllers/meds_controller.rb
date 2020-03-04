class MedsController < ApplicationController
  get '/meds' do
    if logged_in?
      @meds = Med.all
      erb :'meds/meds'
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
      if params[:name] == ""
        redirect to "/meds/new"
      else
        @med = current_user.meds.build(name: params[:name], price: params[:price], num_pills: params[:num_pills])
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
      @med = Med.find_by_id(params[:id])
      erb :'meds/show_meds'
    else
      redirect to '/login'
    end
  end

  get '/meds/:id/edit' do
    if logged_in?
      @med = Med.find_by_id(params[:id])
      if @med && @med.user == current_user
        erb :'meds/edit_meds'
      else
        redirect to '/meds'
      end
    else
      redirect to '/login'
    end
  end

  patch '/meds/:id' do
    if logged_in?
      if params[:name] == ""
        redirect to "/meds/#{params[:id]}/edit"
      else
        @med = Med.find_by_id(params[:id])
        if @med && @med.user == current_user
          if @med.update(name: params[:name])
            redirect to "/meds/#{@med.id}"
          else
            redirect to "/meds/#{@med.id}/edit"
          end
        else
          redirect to '/meds'
        end
      end
    else
      redirect to '/login'
    end
  end

  delete '/meds/:id/delete' do
    if logged_in?
      @med = Med.find_by_id(params[:id])
      if @med && @med.user == current_user
        @med.delete
      end
      redirect to '/meds'
    else
      redirect to '/login'
    end
  end
end
