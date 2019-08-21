module Percy
  class Client
    module Snapshots
      def create_snapshot(build_id, resources, options = {})
        unless resources.respond_to?(:each)
          raise ArgumentError,
            'resources argument must be an iterable of Percy::Client::Resource objects'
        end

        widths = options[:widths] || config.default_widths
        data = {
          'data' => {
            'type' => 'snapshots',
            'attributes' => {
              'name' => options[:name],
              'enable-javascript' => options[:enable_javascript],
              'minimum-height' => options[:minimum_height],
              'widths' => widths,
            },
            'relationships' => {
              'resources' => {
                'data' => resources.map(&:serialize),
              },
            },
          },
        }
        post("#{config.api_url}/builds/#{build_id}/snapshots/", data)
      end

      def finalize_snapshot(snapshot_id)
        post("#{config.api_url}/snapshots/#{snapshot_id}/finalize", {})
      end
    end
  end
end
