class RawEmail < ActiveRecord::Base

  # Regex to parse email

  MESSAGE_ID = /Message-ID: [^>]*>/i
  DATE = /((Date: [^\+|\-]+[\+|\-\d]+))/m
  TO = /(To: .*?[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}+(>|)(|, ))/i
  AUTHENTICATION_RESULTS = /Authentication-Results: (.*)/
  FROM = /From: [^>]+>(|, )/i
  RETURN_PATH = /Return-Path: [^>]+>(|, )/i
  CONTENT_TYPE = /Content-Type: [^=]+=[^\s]+/i
  CONTENT_TRANSFER_ENCODING = /Content-transfer-encoding: (base64|quoted-printable|8bit|binary|x-token|7bit)/i
  MIME_VERSION = /Mime-version: \d\.\d/i
  DKIM_SIGNATURE = /DKIM-Signature: [^>]*[^=]*==/i
  REFERENCES = /References: [^>]+>[^>]+>/i
  SUBJECT = /Subject: [^\\]*/m
  RECEIVED_FROM = /Received: from [^;]+;[^-|\+]+[+\|-]+\d+/i
  RECEIVED_BY = /Received: by [^;]+;[^)]+\)/i
  RECEIVED_SPF = /Received-SPF: pass [^;]+;/i
  BODY = /Content-Type: [\s\S\w\W\b\D\d]*\n/i

  def text_input
    @text = raw_email.to_s
  end

  def parse_headers
    a = []
    a << message_id = @text.match(MESSAGE_ID)
    a << date = @text.match(DATE)
    a << to = @text.match(TO)
    a << user_agent = @text.match(AUTHENTICATION_RESULTS)
    a << from = @text.match(FROM)
    a << return_path = @text.match(RETURN_PATH)
    a << content_type = @text.match(CONTENT_TYPE)
    a << content_transfer_encoding = @text.match(CONTENT_TRANSFER_ENCODING)
    a << mime_version = @text.match(MIME_VERSION)
    a << parse_dkim_signature = @text.match(DKIM_SIGNATURE)
    a << parse_references = @text.match(REFERENCES)
    a << subject = @text.split('\r').to_s.match(SUBJECT)
    a << parse_received_from = @text.match(RECEIVED_FROM)
    a << parse_received_by = @text.match(RECEIVED_BY)
    a << parse_received_spf = @text.match(RECEIVED_SPF)
    a.compact
  end 

  def parse_body
    @parse_body = @text.match(BODY)
  end
end
