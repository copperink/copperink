module CreationScopes
  extend ActiveSupport::Concern

  included do
    scope :oldest_first, -> { order(__creation_field__ => :asc)  }
    scope :newest_first, -> { order(__creation_field__ => :desc) }

    def self.__creation_field__
      :created_at
    end
  end
end
