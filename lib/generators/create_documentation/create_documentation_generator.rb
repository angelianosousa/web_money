class CreateDocumentationGenerator < Rails::Generators::NamedBase
  attr_accessor :tables, :objects

  source_root File.expand_path('templates', __dir__)

  # Build c4builder files
  def initial_c4builder_struct
    copy_file 'context.md', 'src/context.md'

    @objects = {}
    Rails.application.eager_load! # To load tables
    @tables = ActiveRecord::Base.connection.tables[1..-4].sort # getting table list
    getting_example_objects
  end

  def create_models_md
    @tables.each do |model|
      fields = ActiveRecord::Base.connection.columns(model.pluralize).map(&:name) # @objects[model.capitalize.singularize]#.map(&:name) # getting a field list

      create_file "src/#{model}/README.md", <<~MD
        ## Descrição da classe

        O que essa classe faz ?
        Qual seu objetivo ?

        ## Campos
        #{fields}

        ## Funcionalidades

        * Contexto em que é útil
        * Como o usuário interage com ela

        # Banco de dados

      MD
    end
  end

  def create_diagram_of_models
    @tables.each do |model|
      fields = @objects[model.capitalize.singularize]

      create_file "src/#{model}/context.puml", <<~PUML
        !include <C4/C4_Container>

        @startjson C4_Elements
          #{fields}
        @endjson
      PUML
    end
  end

  def getting_example_objects
    @descendants = ActiveRecord::Base.descendants[1..-5]

    # Separate the fields per class
    @descendants.each do |class_type|
      next if class_type.first.nil?

      @objects["#{class_type.first.model_name.name}"] = class_type.first
    end
  end
end
