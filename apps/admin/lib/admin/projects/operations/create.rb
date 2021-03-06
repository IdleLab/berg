require "admin/import"
require "admin/entities/project"
require "admin/projects/validation/form"
require "dry-result_matcher"
require "kleisli"

module Admin
  module Projects
    module Operations
      class Create
        include Admin::Import(
          "admin.persistence.repositories.projects",
          "admin.slugify",
          "admin.persistence.project_color_picker",
        )

        include Dry::ResultMatcher.for(:call)

        def call(attributes)
          validation = Validation::Form.(attributes)

          if validation.success?
            project = Entities::Project.new(projects.create(prepare_attributes(validation.output)))
            Right(project)
          else
            Left(validation)
          end
        end

        private

        def prepare_attributes(attributes)
          attributes.merge(
            slug: slugify.(attributes[:title], projects.method(:slug_exists?)),
            color: project_color_picker.()
          )
        end
      end
    end
  end
end
