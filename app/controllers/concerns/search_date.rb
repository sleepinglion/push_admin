module SearchDate
    protected

    def change_date(dd, end_date = true)
        dda = if !dd.to_s.empty?
                  dd.split('/')
              else
                  ''
              end

        if dda.length != 3
            if end_date
                return Time.now.to_datetime
            else
                return '1971-01-01'.to_datetime
            end
        end

        dda = dd.split('/')

        if end_date
            aa = "#{dda[2]}-#{dda[0]}-#{dda[1]}".to_date
            @end_date = dd
            return "#{aa} 23:59:59"
        else
            @start_date = dd
            return "#{dda[2]}-#{dda[0]}-#{dda[1]}".to_datetime
        end
    end
end
