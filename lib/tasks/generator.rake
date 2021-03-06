require 'tempfile'

namespace :foreman_yupana do
  namespace :report do
    desc 'Generate yupana report to be sent to Red Hat cloud'
    task generate: :environment do
      target = ENV['target'] || 'hosts_report.tar.gz'
      portal_user = ENV['portal_user'] || 'anonymous'

      archived_report_generator = ForemanYupana::Generators::ArchivedReport.new(target)
      archived_report_generator.render(portal_user)
    end
  end
end
