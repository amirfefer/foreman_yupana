require 'open3'

module ForemanYupana
  module Async
    class ShellProcess
      include SuckerPunch::Job

      def perform(instance_label)
        klass_name = self.class.name
        SuckerPunch.logger.debug("Starting #{klass_name} with label #{instance_label}")
        progress_output = ProgressOutput.register(instance_label)
        Open3.popen2e(env, command) do |_stdin, stdout_stderr, wait_thread|
          progress_output.status = "Running in pid #{wait_thread.pid}"

          stdout_stderr.each do |out_line|
            progress_output.write_line(out_line)
          end

          progress_output.status = wait_thread.value.to_s
        end
        SuckerPunch.logger.debug("Finished job #{klass_name} with label #{instance_label}")
      ensure
        progress_output.close
      end

      def command; end

      def env
        {}
      end
    end
  end
end
