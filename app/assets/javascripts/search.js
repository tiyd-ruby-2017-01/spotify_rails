$(document).ready(function() {
  getJob()
})

function getJob() {
  if (typeof jid === 'undefined') return

  $.ajax({
    method: 'GET',
    url: `/jobs/${jid}`
  }).then(function(job) {

    console.log('job:', job);
    if (!job.complete) {
      setTimeout(getJob, 100)

    } else {
      window.location = `/search/${jid}`
    }
  })
}
