class PetsController < ApplicationController

    get '/pets' do # pet list 
      
      if is_logged_in?
        @pets = current_user.pets.all 
        erb :'/pets/index'
      else
        redirect '/'
      end
    end

    get '/pets/new' do 
      
      if is_logged_in? 
        erb :'/pets/new'
      else
        redirect '/'
      end
    end

    post '/pets' do #create a new pet obj based on form (user) input
      if !is_logged_in?
        redirect '/'
      end
      
      if (params[:pet_name] != "" && params[:pet_birthday] != "" && params[:pet_weight] != "" && params[:pet_description] != "")
        @pet = current_user.pets.create(params)
          redirect "/pets/#{@pet.id}"
      else
       redirect "users/#{current_user.id}"
      end
    end
      
    
    get '/pets/:id' do
      @pet = current_user.pets.find_by(id: params[:id])
      erb :'pets/show'
    end

    get '/pets/:id/edit' do 
      @pet = current_user.pets.find_by(id: params[:id])
      erb :'pets/edit'
    end

    patch '/pets/:id' do 
 
      if !is_logged_in?
        redirect '/'
      end
      
      @pet = current_user.pets.find_by(id: params[:id])
      if (params[:pet_name] != "" && params[:pet_birthday] != "" && params[:pet_weight] != "" && params[:pet_description] != "")
  
          @pet.update(
            pet_name: params[:pet_name],
            pet_birthday: params[:pet_birthday],
            pet_weight: params[:pet_weight],
            pet_description: params[:pet_description],
            category: params[:category]
          )
      end   
      redirect "/pets" 
    end

    delete '/pets/:id' do
      if !is_logged_in?
        redirect '/'
      end
      @pet = current_user.pets.find_by(id: params[:id])
      if @pet.user == current_user
        @pet.destroy
        flash[:message]= "Pet has been succesfully deleted."
        redirect '/pets'
      else
        redirect '/pets'
      end
    end

    private
    
end


