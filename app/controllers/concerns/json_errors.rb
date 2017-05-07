module JSONErrors
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :render_500

    def render_errors(errors, status = 400)
      data = {
        status: 'failed',
        errors: Array.wrap(errors)
      }

      render json: data , status: status
    end


    def render_400(errors = 'required parameters invalid')
      render_errors(errors, 400)
    end

    def render_401(errors = 'unauthorized access')
      render_errors(errors, 401)
    end

    def render_404(errors = 'not found')
      render_errors(errors, 404)
    end

    def render_422(errors = 'could not save data')
      render_errors(errors, 422)
    end

    def render_500(errors = 'internal server error')
      render_errors(errors, 500)
    end
  end
end
