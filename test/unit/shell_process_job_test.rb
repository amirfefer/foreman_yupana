require 'test_plugin_helper'
require 'sucker_punch/testing/inline'

class ShellProcessJobTest < ActiveSupport::TestCase
  class TestProcessJob < ForemanYupana::Async::ShellProcess
    def command
      'echo testing env: $testenv'
    end

    def env
      super.merge(
        'testenv' => 'test_val'
      )
    end
  end

  include FolderIsolation

  test 'Runs a process with environment vars' do
    label = Foreman.uuid
    TestProcessJob.perform_async(label)

    progress_output = ForemanYupana::Async::ProgressOutput.get(label)

    assert_match(/test_val/, progress_output.full_output)
    assert_match(/exit 0/, progress_output.status)
  end
end
