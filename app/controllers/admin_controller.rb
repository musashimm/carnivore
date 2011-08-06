class AdminController < ApplicationController

def login
	@login_page = true
	@categories = get_all_categories()
	@updatetime = get_update_time(nil)
end

def create_session

  if params[:username] == $defaults["username"] && params[:password] == $defaults["password"]
  	session[:username] = params[:username]
  	session[:password] = params[:password]
  	flash[:notice] = "Zalogowanie poprawne."
  else
	flash[:error] = "Zalogowanie niepoprawne."
  end

  redirect_to root_path

end

def logout
  reset_session
  flash[:notice] = "Wylogowanie poprawne."
  redirect_to root_path
end

end
