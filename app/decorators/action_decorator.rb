# frozen_string_literal: true

module ActionDecorator
    def fait_humanized 
        !self.fait.nil? ? (self.fait ? 'Oui' : 'Non') : ''
    end
end
