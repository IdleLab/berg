require "admin/import"
require "admin/people/validation/form"
require "kleisli"

module Admin
  module People
    module Operations
      class Update
        include Admin::Import(
          "admin.persistence.repositories.people"
        )

        include Dry::ResultMatcher.for(:call)

        def call(id, attributes)
          validation = Validation::Form.(prepare_attributes(attributes))

          if validation.success?
            people.update(id, prepare_avatar(validation.to_h))
            Right(people[id])
          else
            Left(validation)
          end
        end

        private

        def prepare_attributes(attributes)
          attributes.merge(
            previous_email: attributes["email"],
            avatar: attributes["avatar"]
          )
        end

        def prepare_avatar(attributes)
          attributes.merge(
            avatar: attributes[:avatar].to_json
          )
        end
      end
    end
  end
end
