import React from 'react';
import PropTypes from 'prop-types';
import { noop } from 'patternfly-react';
import TabContainer from '../TabContainer';
import TabHeader from '../TabHeader';
import TabBody from '../TabBody';
import './reportUpload.scss';

const ReportUpload = ({
  exitCode,
  loading,
  logs,
  completed,
  downloadReports,
  restartProcess,
  error,
}) => (
  <TabContainer className="report-upload">
    <TabHeader
      exitCode={exitCode}
      onRestart={restartProcess}
      onDownload={downloadReports}
    />
    <TabBody
      loading={loading}
      logs={logs}
      completed={completed}
      error={error}
    />
  </TabContainer>
);

ReportUpload.propTypes = {
  exitCode: PropTypes.oneOfType([PropTypes.string, PropTypes.number]),
  loading: PropTypes.bool,
  logs: PropTypes.oneOfType([
    PropTypes.arrayOf(PropTypes.string),
    PropTypes.string,
  ]),
  completed: PropTypes.number,
  restartProcess: PropTypes.func,
  downloadReports: PropTypes.func,
  error: PropTypes.string,
};

ReportUpload.defaultProps = {
  exitCode: 0,
  loading: false,
  logs: ['No running process'],
  completed: 0,
  restartProcess: noop,
  downloadReports: noop,
  error: null,
};

export default ReportUpload;
