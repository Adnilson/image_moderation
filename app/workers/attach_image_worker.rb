class AttachImageWorker
	include Sidekiq::Worker

	def perform(report_id, image_url)
		url = URI.parse(image_url)

		remote_file = Net::HTTP.get_response(url)
    file = StringIO.new(remote_file.body)

    filename = File.basename(url.path)

    report = Report.find(report_id)
    report.image.attach(io: file, filename: filename)
	end
end