Geocoder.configure(
  lookup: :google,
  always_raise: [
    Geocoder::OverQueryLimitError,
    Geocoder::RequestDenied,
    Geocoder::InvalidRequest,
    Geocoder::InvalidApiKey
  ],
  api_key:  ENV['GOOGLEMAP'] ,
  use_https: true
)

Geocoder::Lookup::Test.add_stub(
  "東京", [
    {
      'coordinates'  => [35.681236, 139.767125],
      'address'      => 'Tokyo, Japan',
    }
  ]
)