require "active_job"
module ActiveJobStatus
  class TrackableJob < ActiveJob::Base

    before_enqueue { ActiveJobStatus::JobTracker.enqueue(job_id: @job_id) }

    before_perform { ActiveJobStatus::JobTracker.update(job_id: @job_id, status: :working) }

    after_perform { ActiveJobStatus::JobTracker.complete(job_id: @job_id,status: :complete) }
  end
end
