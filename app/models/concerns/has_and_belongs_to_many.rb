module HasAndBelongsToMany
  extend ActiveSupport::Concern

  module ClassMethods
    def method_missing(method_name, *args, &block)
      prefix = args.first

      if respond_to_missing?(method_name)
        has_and_belongs_to_many relation_name(method_name), class_name: class_name(method_name), join_table: join_table_name(prefix, method_name)
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      method_name.to_s.start_with?('has_and_belongs_to_many_') || super
    end

    private

    def user_name
      User.name.singularize.downcase
    end

    def reference_name(method_name)
      if self.name.constantize.eql?(User)
        method_name.to_s.split('_').last
      else
        self.name
      end.singularize.downcase
    end

    def relation_name(method_name)
      method_name.to_s.sub(/has_and_belongs_to_many_/, '').downcase.pluralize.to_sym
    end

    def class_name(method_name)
      if self.name.constantize.eql?(User)
        reference_name(method_name)
      else
        user_name
      end.camelize
    end

    def prefix_name(prefix)
      prefix.to_s.present? ? "_#{prefix}_" : '_'
    end

    def join_table_name(prefix, method_name)
      "#{user_name.pluralize}#{prefix_name(prefix)}#{reference_name(method_name).pluralize}".downcase.to_sym
    end
  end
end
