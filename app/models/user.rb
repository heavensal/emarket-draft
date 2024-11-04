class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [ :google_oauth2 ], stretches: 12

  has_many :carts, dependent: :destroy

  # omniauth
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.skip_confirmation!
    end
  end

  # ROLES
  def admin?
    role == "admin"
  end

  def customer?
    role == "customer"
  end

  def admin!
    update(role: "admin")
  end

  def customer!
    update(role: "customer")
  end

  # DIFFERENT METHODS FOR USER
  # before_action :authenticate_user! # to protect the routes
  # before_action :authenticate_user!, except: [:index, :show] # to protect the routes except index and show
  # user_signed_in? # to check if user is signed in
  # current_user # to get the current user
  # user_session # to get the current session
  # user_session["key"] = "value" # to set a session value
end
