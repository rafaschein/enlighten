module FollowablePolicy
  class << self
    def follow?
      true
    end

    def unfollow?
      true
    end
  end
end
