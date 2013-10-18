module LoginMacros
  #use this for integration tests (ie. stuff in spec/requests)
  def login_integration
    before do 
      @user = FactoryGirl.create(:user)
      #ApplicationController.skip_after_sign_in 
      post user_session_path, :user => {:email => @user.email, :password => 'supersecretpasswordstuff'}
    end
  end
  
  #use this for unit tests (ie. stuff in spec/controllers)
  def login
    before do 
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryGirl.create(:user)
      sign_in @user
    end
  end
end