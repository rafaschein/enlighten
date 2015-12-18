module Authenticatable
  extend ActiveSupport::Concern

  included do
    devise :ldap_authenticatable, :rememberable, :trackable if LDAP.enabled?
    devise :database_authenticatable, :rememberable, :trackable unless LDAP.enabled?
  end
end
