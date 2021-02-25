class App

  CORRECT_URL = '/time'.freeze
  PARAMS_KEY = 'format'.freeze

  def call(env)
    request = Rack::Request.new(env)
    params = request.params[PARAMS_KEY]
    if url_ok?(env['REQUEST_PATH']) && request.get?
      check_params(params)
    else
      response(404, 'Incorrect url')
    end
  end

  private

  def url_ok?(url)
    url == CORRECT_URL
  end

  def response(status, body)
    Rack::Response.new(body, status, { 'Content-Type' => 'text/plain' }).finish
  end

  def check_params(params)
    tf = TimeFormat.new(params)
    tf.call

    if tf.success?
      response(200, tf.time_text)
    else
      response(400, tf.invalid_params)
    end
  end
end
