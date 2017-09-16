class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def resource_class
    self.class.to_s.underscore
  end

  def self.accepts_pastables_for(*textareas)
    [:images, :codes].each do |pastable|
      has_many pastable, dependent: :destroy
      accepts_nested_attributes_for pastable, allow_destroy: true, reject_if: -> attributes {
        # Ignore lock_version and _destroy when checking for attributes
        attributes.all? { |key, value| %w(_destroy lock_version).include?(key) || value.blank? }
      }
    end

    define_method :textareas_accepting_pastables do
      textareas
    end
  end

  # If it's a translated attribute in not the current language, its name in the current language is returned together with the language abbreviation in brackets. E.g. if the current language is english and the human name for attribute `content_de`, the returned value is "Content (de)".
  def self.human_attribute_name(attribute_key_name, options = {})
    if match = attribute_key_name.match(/^(#{translated_attribute_names.join('|')})_(#{I18n.available_locales.join('|')})$/)
      human_attribute_name = super(match[1], options)

      if match[2] == I18n.locale.to_s
        human_attribute_name
      else
        human_attribute_name + " (#{match[2]})"
      end
    else
      super(attribute_key_name, options)
    end
  end
end
