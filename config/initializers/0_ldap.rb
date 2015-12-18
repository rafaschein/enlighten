module LDAP
  def self.enabled?
    Figaro.env.ldap_enabled == "true"
  end
end
