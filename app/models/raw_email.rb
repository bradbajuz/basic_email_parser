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

  def parse_message_id
    message_id = @text.match(MESSAGE_ID)
  end 

  def parse_date
    date = @text.match(DATE)
  end

  def parse_to
    to = @text.match(TO)
  end

  def parse_authentication_results
    user_agent = @text.match(AUTHENTICATION_RESULTS)
  end

  def parse_from
    from = @text.match(FROM)
  end

  def parse_return_path
    return_path = @text.match(RETURN_PATH)
  end

  def parse_content_type
    @content_type = @text.match(CONTENT_TYPE)
  end

  def parse_content_transfer_encoding
    content_transfer_encoding = @text.match(CONTENT_TRANSFER_ENCODING)
  end

  def parse_mime_version
    mime_version = @text.match(MIME_VERSION)
  end

  def parse_dkim_signature
    parse_dkim_signature = @text.match(DKIM_SIGNATURE)
  end

  def parse_references
    parse_references = @text.match(REFERENCES)
  end

  def parse_subject
    subject = @text.split('\r').to_s.match(SUBJECT)
  end

  def parse_received_from
    parse_received_from = @text.match(RECEIVED_FROM)
  end

  def parse_received_by
    parse_received_by = @text.match(RECEIVED_BY)
  end

  def parse_received_spf
    parse_received_spf = @text.match(RECEIVED_SPF)
  end

  def parse_body
     @parse_body = @text.match(BODY)
  end
end
