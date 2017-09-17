module ErrorSerializer
  class << self
    def to_404(resource)
      { message: "#{resource} Not Found", http_status: 404 }
    end

    def to_400(resource, errors)
      { message: "#{resource} Is Invalid", http_status: 400, errors: errors }
    end

    def to_422(resource, errors)
      message = { message: "Error on proccess entity #{resource}", http_status: 422 }

      newErrors = []
      errors.each do |field, fieldErrors|
        fieldErrors.each do |fieldErrorMessage|
          newErrors << "#{field} #{fieldErrorMessage}"
        end
      end

      message[:errors] = newErrors

      message
    end
  end
end
