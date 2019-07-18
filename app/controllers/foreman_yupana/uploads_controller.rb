module ForemanYupana
  class UploadsController < ::ApplicationController
    def last
      output = ForemanYupana::Async::ProgressOutput.registry[ForemanYupana.uploader_output]&.full_output

      render json: {
        status: 'Unknown',
        output: output
      }, status: :ok
    end
  end
end