module Avo
  module Resources
    # User resource for admin
    class User < Avo::BaseResource
      self.includes = [:roles]
      # self.attachments = []
      # self.search = {
      #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
      # }

      def fields
        field :id, as: :id
        field :email, as: :text
        field :sign_in_count, as: :number
        field :current_sign_in_at, as: :date_time
        field :current_sign_in_ip, as: :text
        field :last_sign_in_ip, as: :text
        field :roles, as: :has_many
      end
    end
  end
end
