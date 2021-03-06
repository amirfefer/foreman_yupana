module ForemanYupana
  class ReportsController < ::ApplicationController
    def last
      label = ForemanYupana::Async::GenerateReportJob.output_label(params[:portal_user])
      output = ForemanYupana::Async::ProgressOutput.get(label)&.full_output

      render json: {
        output: output
      }, status: :ok
    end
  end
end
