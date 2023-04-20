class MessagesToXls < ApplicationService
  require 'spreadsheet'
  attr_reader :messages

  def initialize(messages)
      @messages = messages
  end

  def call
      headers = %w{ Id Nom Structure E-mail Téléphone Message État Tag1 Tag2 Tag3 Date_Création Date_MAJ }
  
      Spreadsheet.client_encoding = 'UTF-8'
  
      book = Spreadsheet::Workbook.new
      sheet = book.create_worksheet name: 'Messages'
      bold = Spreadsheet::Format.new :weight => :bold, :size => 11
  
      sheet.row(0).concat headers
      sheet.row(0).default_format = bold
  
      index = 1
      @messages.each do | message |
        fields_to_export = [
          message.id, 
          message.nom, 
          message.structure,
          message.email,
          message.téléphone,
          message.message,
          message.workflow_state,
          message.tag_list[0],
          message.tag_list[1],
          message.tag_list[2],
          message.created_at,
          message.updated_at
        ]
        sheet.row(index).replace fields_to_export
        index += 1
      end
      return book
  end
  
end