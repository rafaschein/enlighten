class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  def method_missing(method_sym)
    permission?(method_sym)
  end

  private

  def model_symbol
    record.is_a?(Symbol) ? record : record.class.name.downcase.to_sym
  end

  def model_name
    model_symbol.to_s
  end

  def action_name(method_sym)
    method_sym.to_s.downcase.delete('?')
  end

  def permission?(method_sym)
    user.permission_roles.each do |role|
      role.permission_acls.each do |acl|
        return true if acl.model == model_name && acl.action == action_name(method_sym)
      end
    end

    false
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
