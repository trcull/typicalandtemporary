# from: https://bigml.com/user/ashikiar/gallery/model/52125966035d0738830000b9
class BigmlModel
def predict_churn(data={})
    """ Predictor for churn from model/52125966035d0738830000b9

        predicting mobile carrier customer churn
    """
    if (data[:total_day_charge].nil?)
        return 'False'
    end
    if (data[:total_day_charge] > 44.92187)
        if (data[:number_vmail_messages].nil?)
            return 'True'
        end
        if (data[:number_vmail_messages] <= 6)
            if (data[:total_eve_charge].nil?)
                return 'True'
            end
            if (data[:total_eve_charge] > 15.695)
                if (data[:total_night_minutes].nil?)
                    return 'True'
                end
                if (data[:total_night_minutes] <= 164)
                    if (data[:total_day_charge] > 47.115)
                        return 'True'
                    end
                    if (data[:total_day_charge] <= 47.115)
                        if (data[:total_intl_calls].nil?)
                            return 'False'
                        end
                        if (data[:total_intl_calls] <= 4)
                            if (data[:total_intl_minutes].nil?)
                                return 'False'
                            end
                            if (data[:total_intl_minutes] > 14.2)
                                return 'True'
                            end
                            if (data[:total_intl_minutes] <= 14.2)
                                return 'False'
                            end
                        end
                        if (data[:total_intl_calls] > 4)
                            return 'True'
                        end
                    end
                end
                if (data[:total_night_minutes] > 164)
                    return 'True'
                end
            end
            if (data[:total_eve_charge] <= 15.695)
                if (data[:total_day_charge] <= 47.21)
                    if (data[:total_night_charge].nil?)
                        return 'False'
                    end
                    if (data[:total_night_charge] > 12.495)
                        return 'True'
                    end
                    if (data[:total_night_charge] <= 12.495)
                        if (data[:total_intl_minutes].nil?)
                            return 'False'
                        end
                        if (data[:total_intl_minutes] <= 17.15)
                            return 'False'
                        end
                        if (data[:total_intl_minutes] > 17.15)
                            return 'True'
                        end
                    end
                end
                if (data[:total_day_charge] > 47.21)
                    if (data[:total_eve_charge] > 12.27)
                        if (data[:total_night_charge].nil?)
                            return 'True'
                        end
                        if (data[:total_night_charge] <= 6.835)
                            if (data[:total_night_calls].nil?)
                                return 'False'
                            end
                            if (data[:total_night_calls] > 68)
                                return 'False'
                            end
                            if (data[:total_night_calls] <= 68)
                                return 'True'
                            end
                        end
                        if (data[:total_night_charge] > 6.835)
                            return 'True'
                        end
                    end
                    if (data[:total_eve_charge] <= 12.27)
                        if (data[:total_intl_minutes].nil?)
                            return 'False'
                        end
                        if (data[:total_intl_minutes] <= 10.15)
                            return 'False'
                        end
                        if (data[:total_intl_minutes] > 10.15)
                            return 'True'
                        end
                    end
                end
            end
        end
        if (data[:number_vmail_messages] > 6)
            if (data[:international_plan].nil?)
                return 'False'
            end
            if (data[:international_plan] == 'yes')
                if (data[:total_day_charge] <= 46.975)
                    return 'True'
                end
                if (data[:total_day_charge] > 46.975)
                    if (data[:total_intl_minutes].nil?)
                        return 'False'
                    end
                    if (data[:total_intl_minutes] > 13.4)
                        return 'True'
                    end
                    if (data[:total_intl_minutes] <= 13.4)
                        return 'False'
                    end
                end
            end
            if (data[:international_plan] == 'no')
                if (data[:total_day_charge] <= 54.23)
                    return 'False'
                end
                if (data[:total_day_charge] > 54.23)
                    return 'True'
                end
            end
        end
    end
    if (data[:total_day_charge] <= 44.92187)
        if (data[:customer_service_calls].nil?)
            return 'False'
        end
        if (data[:customer_service_calls] <= 3)
            if (data[:international_plan].nil?)
                return 'False'
            end
            if (data[:international_plan] == 'yes')
                if (data[:total_intl_calls].nil?)
                    return 'False'
                end
                if (data[:total_intl_calls] <= 2)
                    return 'True'
                end
                if (data[:total_intl_calls] > 2)
                    if (data[:total_intl_minutes].nil?)
                        return 'False'
                    end
                    if (data[:total_intl_minutes] > 13.1)
                        return 'True'
                    end
                    if (data[:total_intl_minutes] <= 13.1)
                        if (data[:total_day_charge] <= 40.71)
                            if (data[:total_night_charge].nil?)
                                return 'False'
                            end
                            if (data[:total_night_charge] > 3.79)
                                if (data[:total_eve_charge].nil?)
                                    return 'False'
                                end
                                if (data[:total_eve_charge] <= 27.285)
                                    return 'False'
                                end
                                if (data[:total_eve_charge] > 27.285)
                                    if (data[:total_day_charge] > 35.565)
                                        return 'True'
                                    end
                                    if (data[:total_day_charge] <= 35.565)
                                        return 'False'
                                    end
                                end
                            end
                            if (data[:total_night_charge] <= 3.79)
                                return 'True'
                            end
                        end
                        if (data[:total_day_charge] > 40.71)
                            if (data[:total_eve_charge].nil?)
                                return 'False'
                            end
                            if (data[:total_eve_charge] > 20.89)
                                if (data[:total_night_charge].nil?)
                                    return 'True'
                                end
                                if (data[:total_night_charge] <= 8.26)
                                    return 'True'
                                end
                                if (data[:total_night_charge] > 8.26)
                                    return 'False'
                                end
                            end
                            if (data[:total_eve_charge] <= 20.89)
                                return 'False'
                            end
                        end
                    end
                end
            end
            if (data[:international_plan] == 'no')
                if (data[:total_day_charge] <= 38.08672)
                    if (data[:total_night_charge].nil?)
                        return 'False'
                    end
                    if (data[:total_night_charge] > 5.8254)
                        if (data[:total_eve_charge].nil?)
                            return 'False'
                        end
                        if (data[:total_eve_charge] <= 27.72033)
                            if (data[:total_eve_charge] > 14.06923)
                                if (data[:total_day_charge] <= 35.75136)
                                    if (data[:total_night_calls].nil?)
                                        return 'False'
                                    end
                                    if (data[:total_night_calls] > 104)
                                        if (data[:total_eve_minutes].nil?)
                                            return 'False'
                                        end
                                        if (data[:total_eve_minutes] <= 279.115)
                                            if (data[:total_intl_calls].nil?)
                                                return 'False'
                                            end
                                            if (data[:total_intl_calls] > 8)
                                                return 'False'
                                            end
                                            if (data[:total_intl_calls] <= 8)
                                                if (data[:total_eve_charge] <= 20.88292)
                                                    if (data[:total_day_charge] > 22.59662)
                                                        if (data[:account_length].nil?)
                                                            return 'False'
                                                        end
                                                        if (data[:account_length] <= 151)
                                                            if (data[:area_code].nil?)
                                                                return 'False'
                                                            end
                                                            if (data[:area_code] != '415')
                                                                return 'False'
                                                            end
                                                            if (data[:area_code] == '415')
                                                                if (data[:customer_service_calls] <= 1)
                                                                    if (data[:total_intl_calls] > 3)
                                                                        if (data[:total_night_charge] <= 5.895)
                                                                            return 'True'
                                                                        end
                                                                        if (data[:total_night_charge] > 5.895)
                                                                            if (data[:total_day_calls].nil?)
                                                                                return 'False'
                                                                            end
                                                                            if (data[:total_day_calls] > 93)
                                                                                return 'False'
                                                                            end
                                                                            if (data[:total_day_calls] <= 93)
                                                                                return 'False'
                                                                            end
                                                                        end
                                                                    end
                                                                    if (data[:total_intl_calls] <= 3)
                                                                        return 'False'
                                                                    end
                                                                end
                                                                if (data[:customer_service_calls] > 1)
                                                                    return 'False'
                                                                end
                                                            end
                                                        end
                                                        if (data[:account_length] > 151)
                                                            if (data[:total_day_calls].nil?)
                                                                return 'False'
                                                            end
                                                            if (data[:total_day_calls] > 121)
                                                                if (data[:total_intl_minutes].nil?)
                                                                    return 'True'
                                                                end
                                                                if (data[:total_intl_minutes] <= 13.4)
                                                                    if (data[:total_intl_minutes] > 8.95)
                                                                        return 'True'
                                                                    end
                                                                    if (data[:total_intl_minutes] <= 8.95)
                                                                        return 'False'
                                                                    end
                                                                end
                                                                if (data[:total_intl_minutes] > 13.4)
                                                                    return 'False'
                                                                end
                                                            end
                                                            if (data[:total_day_calls] <= 121)
                                                                return 'False'
                                                            end
                                                        end
                                                    end
                                                    if (data[:total_day_charge] <= 22.59662)
                                                        if (data[:total_intl_calls] <= 5)
                                                            if (data[:total_eve_charge] > 19.355)
                                                                return 'False'
                                                            end
                                                            if (data[:total_eve_charge] <= 19.355)
                                                                if (data[:account_length].nil?)
                                                                    return 'False'
                                                                end
                                                                if (data[:account_length] <= 25)
                                                                    return 'True'
                                                                end
                                                                if (data[:account_length] > 25)
                                                                    if (data[:total_eve_calls].nil?)
                                                                        return 'False'
                                                                    end
                                                                    if (data[:total_eve_calls] > 125)
                                                                        if (data[:total_eve_charge] <= 17.265)
                                                                            return 'False'
                                                                        end
                                                                        if (data[:total_eve_charge] > 17.265)
                                                                            return 'True'
                                                                        end
                                                                    end
                                                                    if (data[:total_eve_calls] <= 125)
                                                                        if (data[:total_night_calls] <= 110)
                                                                            return 'False'
                                                                        end
                                                                        if (data[:total_night_calls] > 110)
                                                                            if (data[:total_night_charge] > 10.83)
                                                                                return 'False'
                                                                            end
                                                                            if (data[:total_night_charge] <= 10.83)
                                                                                return 'False'
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                        if (data[:total_intl_calls] > 5)
                                                            return 'False'
                                                        end
                                                    end
                                                end
                                                if (data[:total_eve_charge] > 20.88292)
                                                    if (data[:total_day_calls].nil?)
                                                        return 'False'
                                                    end
                                                    if (data[:total_day_calls] > 105)
                                                        return 'False'
                                                    end
                                                    if (data[:total_day_calls] <= 105)
                                                        if (data[:total_intl_minutes].nil?)
                                                            return 'False'
                                                        end
                                                        if (data[:total_intl_minutes] <= 8.2)
                                                            return 'False'
                                                        end
                                                        if (data[:total_intl_minutes] > 8.2)
                                                            if (data[:total_intl_minutes] > 8.65)
                                                                if (data[:account_length].nil?)
                                                                    return 'False'
                                                                end
                                                                if (data[:account_length] <= 118)
                                                                    if (data[:total_day_calls] > 64)
                                                                        return 'False'
                                                                    end
                                                                    if (data[:total_day_calls] <= 64)
                                                                        if (data[:total_intl_minutes] <= 10.5)
                                                                            return 'False'
                                                                        end
                                                                        if (data[:total_intl_minutes] > 10.5)
                                                                            return 'True'
                                                                        end
                                                                    end
                                                                end
                                                                if (data[:account_length] > 118)
                                                                    if (data[:total_night_charge] > 8.27)
                                                                        if (data[:total_eve_calls].nil?)
                                                                            return 'False'
                                                                        end
                                                                        if (data[:total_eve_calls] <= 113)
                                                                            return 'False'
                                                                        end
                                                                        if (data[:total_eve_calls] > 113)
                                                                            if (data[:total_intl_minutes] > 10.55)
                                                                                return 'False'
                                                                            end
                                                                            if (data[:total_intl_minutes] <= 10.55)
                                                                                return 'True'
                                                                            end
                                                                        end
                                                                    end
                                                                    if (data[:total_night_charge] <= 8.27)
                                                                        return 'True'
                                                                    end
                                                                end
                                                            end
                                                            if (data[:total_intl_minutes] <= 8.65)
                                                                return 'True'
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                        if (data[:total_eve_minutes] > 279.115)
                                            return 'False'
                                        end
                                    end
                                    if (data[:total_night_calls] <= 104)
                                        if (data[:total_intl_minutes].nil?)
                                            return 'False'
                                        end
                                        if (data[:total_intl_minutes] <= 8.05404)
                                            return 'False'
                                        end
                                        if (data[:total_intl_minutes] > 8.05404)
                                            if (data[:account_length].nil?)
                                                return 'False'
                                            end
                                            if (data[:account_length] > 221)
                                                if (data[:total_intl_minutes] <= 8.75)
                                                    return 'True'
                                                end
                                                if (data[:total_intl_minutes] > 8.75)
                                                    return 'False'
                                                end
                                            end
                                            if (data[:account_length] <= 221)
                                                if (data[:total_eve_charge] <= 19.25017)
                                                    if (data[:total_eve_charge] > 16.91133)
                                                        if (data[:total_intl_minutes] <= 13.15)
                                                            if (data[:total_night_calls] > 93)
                                                                if (data[:total_night_charge] <= 6.84)
                                                                    return 'True'
                                                                end
                                                                if (data[:total_night_charge] > 6.84)
                                                                    if (data[:total_day_charge] > 27.735)
                                                                        if (data[:total_day_charge] <= 28.48)
                                                                            return 'True'
                                                                        end
                                                                        if (data[:total_day_charge] > 28.48)
                                                                            if (data[:total_eve_calls].nil?)
                                                                                return 'False'
                                                                            end
                                                                            if (data[:total_eve_calls] > 133)
                                                                                return 'True'
                                                                            end
                                                                            if (data[:total_eve_calls] <= 133)
                                                                                return 'False'
                                                                            end
                                                                        end
                                                                    end
                                                                    if (data[:total_day_charge] <= 27.735)
                                                                        return 'False'
                                                                    end
                                                                end
                                                            end
                                                            if (data[:total_night_calls] <= 93)
                                                                if (data[:total_intl_minutes] <= 8.35)
                                                                    return 'False'
                                                                end
                                                                if (data[:total_intl_minutes] > 8.35)
                                                                    return 'False'
                                                                end
                                                            end
                                                        end
                                                        if (data[:total_intl_minutes] > 13.15)
                                                            return 'False'
                                                        end
                                                    end
                                                    if (data[:total_eve_charge] <= 16.91133)
                                                        if (data[:total_night_calls] <= 83)
                                                            if (data[:total_intl_minutes] > 10.65)
                                                                return 'False'
                                                            end
                                                            if (data[:total_intl_minutes] <= 10.65)
                                                                if (data[:total_intl_minutes] <= 10.55)
                                                                    if (data[:total_night_calls] > 62)
                                                                        return 'False'
                                                                    end
                                                                    if (data[:total_night_calls] <= 62)
                                                                        return 'True'
                                                                    end
                                                                end
                                                                if (data[:total_intl_minutes] > 10.55)
                                                                    return 'True'
                                                                end
                                                            end
                                                        end
                                                        if (data[:total_night_calls] > 83)
                                                            return 'False'
                                                        end
                                                    end
                                                end
                                                if (data[:total_eve_charge] > 19.25017)
                                                    if (data[:total_night_charge] > 14.935)
                                                        if (data[:total_night_calls] <= 82)
                                                            return 'True'
                                                        end
                                                        if (data[:total_night_calls] > 82)
                                                            return 'False'
                                                        end
                                                    end
                                                    if (data[:total_night_charge] <= 14.935)
                                                        return 'False'
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                                if (data[:total_day_charge] > 35.75136)
                                    if (data[:total_eve_minutes].nil?)
                                        return 'False'
                                    end
                                    if (data[:total_eve_minutes] > 276.275)
                                        if (data[:total_eve_charge] <= 23.98)
                                            return 'True'
                                        end
                                        if (data[:total_eve_charge] > 23.98)
                                            if (data[:total_intl_minutes].nil?)
                                                return 'False'
                                            end
                                            if (data[:total_intl_minutes] > 11.7)
                                                if (data[:total_intl_minutes] <= 13.35)
                                                    return 'True'
                                                end
                                                if (data[:total_intl_minutes] > 13.35)
                                                    return 'False'
                                                end
                                            end
                                            if (data[:total_intl_minutes] <= 11.7)
                                                return 'False'
                                            end
                                        end
                                    end
                                    if (data[:total_eve_minutes] <= 276.275)
                                        if (data[:total_intl_calls].nil?)
                                            return 'False'
                                        end
                                        if (data[:total_intl_calls] <= 6)
                                            if (data[:total_night_charge] > 7.36625)
                                                if (data[:total_night_calls].nil?)
                                                    return 'False'
                                                end
                                                if (data[:total_night_calls] <= 105)
                                                    if (data[:total_day_calls].nil?)
                                                        return 'False'
                                                    end
                                                    if (data[:total_day_calls] > 90)
                                                        return 'False'
                                                    end
                                                    if (data[:total_day_calls] <= 90)
                                                        return 'False'
                                                    end
                                                end
                                                if (data[:total_night_calls] > 105)
                                                    if (data[:total_eve_calls].nil?)
                                                        return 'False'
                                                    end
                                                    if (data[:total_eve_calls] > 72)
                                                        return 'False'
                                                    end
                                                    if (data[:total_eve_calls] <= 72)
                                                        if (data[:total_intl_minutes].nil?)
                                                            return 'False'
                                                        end
                                                        if (data[:total_intl_minutes] <= 9.3)
                                                            return 'True'
                                                        end
                                                        if (data[:total_intl_minutes] > 9.3)
                                                            return 'False'
                                                        end
                                                    end
                                                end
                                            end
                                            if (data[:total_night_charge] <= 7.36625)
                                                return 'False'
                                            end
                                        end
                                        if (data[:total_intl_calls] > 6)
                                            return 'False'
                                        end
                                    end
                                end
                            end
                            if (data[:total_eve_charge] <= 14.06923)
                                if (data[:total_eve_minutes].nil?)
                                    return 'False'
                                end
                                if (data[:total_eve_minutes] <= 146.11116)
                                    if (data[:total_intl_minutes].nil?)
                                        return 'False'
                                    end
                                    if (data[:total_intl_minutes] > 11.07727)
                                        return 'False'
                                    end
                                    if (data[:total_intl_minutes] <= 11.07727)
                                        if (data[:account_length].nil?)
                                            return 'False'
                                        end
                                        if (data[:account_length] <= 142)
                                            if (data[:total_night_calls].nil?)
                                                return 'False'
                                            end
                                            if (data[:total_night_calls] > 79)
                                                return 'False'
                                            end
                                            if (data[:total_night_calls] <= 79)
                                                if (data[:total_eve_calls].nil?)
                                                    return 'False'
                                                end
                                                if (data[:total_eve_calls] <= 82)
                                                    if (data[:total_night_charge] > 7.905)
                                                        return 'True'
                                                    end
                                                    if (data[:total_night_charge] <= 7.905)
                                                        return 'False'
                                                    end
                                                end
                                                if (data[:total_eve_calls] > 82)
                                                    if (data[:total_eve_calls] > 122)
                                                        return 'True'
                                                    end
                                                    if (data[:total_eve_calls] <= 122)
                                                        return 'False'
                                                    end
                                                end
                                            end
                                        end
                                        if (data[:account_length] > 142)
                                            if (data[:total_eve_calls].nil?)
                                                return 'False'
                                            end
                                            if (data[:total_eve_calls] > 75)
                                                if (data[:total_intl_minutes] <= 10.85)
                                                    return 'False'
                                                end
                                                if (data[:total_intl_minutes] > 10.85)
                                                    return 'True'
                                                end
                                            end
                                            if (data[:total_eve_calls] <= 75)
                                                return 'True'
                                            end
                                        end
                                    end
                                end
                                if (data[:total_eve_minutes] > 146.11116)
                                    return 'False'
                                end
                            end
                        end
                        if (data[:total_eve_charge] > 27.72033)
                            if (data[:total_night_charge] > 11.05)
                                if (data[:total_eve_calls].nil?)
                                    return 'True'
                                end
                                if (data[:total_eve_calls] <= 58)
                                    return 'False'
                                end
                                if (data[:total_eve_calls] > 58)
                                    return 'True'
                                end
                            end
                            if (data[:total_night_charge] <= 11.05)
                                return 'False'
                            end
                        end
                    end
                    if (data[:total_night_charge] <= 5.8254)
                        return 'False'
                    end
                end
                if (data[:total_day_charge] > 38.08672)
                    if (data[:total_eve_charge].nil?)
                        return 'False'
                    end
                    if (data[:total_eve_charge] > 20.5105)
                        if (data[:number_vmail_messages].nil?)
                            return 'True'
                        end
                        if (data[:number_vmail_messages] <= 5)
                            if (data[:total_night_minutes].nil?)
                                return 'True'
                            end
                            if (data[:total_night_minutes] > 174.2)
                                if (data[:total_night_charge].nil?)
                                    return 'True'
                                end
                                if (data[:total_night_charge] <= 9.985)
                                    if (data[:total_intl_minutes].nil?)
                                        return 'True'
                                    end
                                    if (data[:total_intl_minutes] > 9.2)
                                        if (data[:total_eve_charge] <= 21)
                                            if (data[:total_day_charge] > 40.88)
                                                return 'True'
                                            end
                                            if (data[:total_day_charge] <= 40.88)
                                                return 'False'
                                            end
                                        end
                                        if (data[:total_eve_charge] > 21)
                                            return 'True'
                                        end
                                    end
                                    if (data[:total_intl_minutes] <= 9.2)
                                        if (data[:total_eve_calls].nil?)
                                            return 'False'
                                        end
                                        if (data[:total_eve_calls] <= 90)
                                            return 'True'
                                        end
                                        if (data[:total_eve_calls] > 90)
                                            if (data[:total_night_charge] > 9.645)
                                                return 'True'
                                            end
                                            if (data[:total_night_charge] <= 9.645)
                                                if (data[:total_day_charge] <= 42.435)
                                                    return 'False'
                                                end
                                                if (data[:total_day_charge] > 42.435)
                                                    return 'True'
                                                end
                                            end
                                        end
                                    end
                                end
                                if (data[:total_night_charge] > 9.985)
                                    return 'True'
                                end
                            end
                            if (data[:total_night_minutes] <= 174.2)
                                if (data[:total_day_charge] <= 41.955)
                                    return 'False'
                                end
                                if (data[:total_day_charge] > 41.955)
                                    if (data[:total_intl_minutes].nil?)
                                        return 'True'
                                    end
                                    if (data[:total_intl_minutes] > 7.55)
                                        return 'True'
                                    end
                                    if (data[:total_intl_minutes] <= 7.55)
                                        return 'False'
                                    end
                                end
                            end
                        end
                        if (data[:number_vmail_messages] > 5)
                            return 'False'
                        end
                    end
                    if (data[:total_eve_charge] <= 20.5105)
                        if (data[:total_eve_charge] <= 14.3875)
                            if (data[:total_day_calls].nil?)
                                return 'False'
                            end
                            if (data[:total_day_calls] > 83)
                                return 'False'
                            end
                            if (data[:total_day_calls] <= 83)
                                return 'False'
                            end
                        end
                        if (data[:total_eve_charge] > 14.3875)
                            if (data[:total_night_charge].nil?)
                                return 'False'
                            end
                            if (data[:total_night_charge] > 7.2175)
                                if (data[:total_day_charge] <= 41.5825)
                                    if (data[:total_intl_minutes].nil?)
                                        return 'False'
                                    end
                                    if (data[:total_intl_minutes] > 10.35)
                                        if (data[:account_length].nil?)
                                            return 'False'
                                        end
                                        if (data[:account_length] <= 24)
                                            return 'True'
                                        end
                                        if (data[:account_length] > 24)
                                            if (data[:total_intl_minutes] > 11.7)
                                                return 'False'
                                            end
                                            if (data[:total_intl_minutes] <= 11.7)
                                                if (data[:total_eve_charge] <= 15.905)
                                                    if (data[:total_intl_minutes] > 10.45)
                                                        return 'True'
                                                    end
                                                    if (data[:total_intl_minutes] <= 10.45)
                                                        return 'False'
                                                    end
                                                end
                                                if (data[:total_eve_charge] > 15.905)
                                                    if (data[:total_night_charge] > 12.61)
                                                        return 'True'
                                                    end
                                                    if (data[:total_night_charge] <= 12.61)
                                                        return 'False'
                                                    end
                                                end
                                            end
                                        end
                                    end
                                    if (data[:total_intl_minutes] <= 10.35)
                                        return 'False'
                                    end
                                end
                                if (data[:total_day_charge] > 41.5825)
                                    if (data[:total_night_charge] > 9.735)
                                        if (data[:total_eve_charge] <= 17.01)
                                            if (data[:total_night_charge] > 13.075)
                                                return 'True'
                                            end
                                            if (data[:total_night_charge] <= 13.075)
                                                return 'False'
                                            end
                                        end
                                        if (data[:total_eve_charge] > 17.01)
                                            if (data[:number_vmail_messages].nil?)
                                                return 'True'
                                            end
                                            if (data[:number_vmail_messages] > 14)
                                                return 'False'
                                            end
                                            if (data[:number_vmail_messages] <= 14)
                                                return 'True'
                                            end
                                        end
                                    end
                                    if (data[:total_night_charge] <= 9.735)
                                        if (data[:total_day_charge] <= 44.685)
                                            return 'False'
                                        end
                                        if (data[:total_day_charge] > 44.685)
                                            if (data[:total_intl_minutes].nil?)
                                                return 'True'
                                            end
                                            if (data[:total_intl_minutes] > 10.85)
                                                return 'True'
                                            end
                                            if (data[:total_intl_minutes] <= 10.85)
                                                return 'False'
                                            end
                                        end
                                    end
                                end
                            end
                            if (data[:total_night_charge] <= 7.2175)
                                return 'False'
                            end
                        end
                    end
                end
            end
        end
        if (data[:customer_service_calls] > 3)
            if (data[:total_day_minutes].nil?)
                return 'True'
            end
            if (data[:total_day_minutes] > 159.7961)
                if (data[:total_eve_charge].nil?)
                    return 'False'
                end
                if (data[:total_eve_charge] <= 12.97333)
                    if (data[:total_day_charge] > 39.76)
                        return 'False'
                    end
                    if (data[:total_day_charge] <= 39.76)
                        if (data[:total_intl_minutes].nil?)
                            return 'True'
                        end
                        if (data[:total_intl_minutes] <= 10.35)
                            return 'True'
                        end
                        if (data[:total_intl_minutes] > 10.35)
                            if (data[:total_day_charge] > 34.36)
                                return 'False'
                            end
                            if (data[:total_day_charge] <= 34.36)
                                if (data[:total_day_calls].nil?)
                                    return 'True'
                                end
                                if (data[:total_day_calls] <= 96)
                                    if (data[:total_intl_minutes] > 11.8)
                                        return 'False'
                                    end
                                    if (data[:total_intl_minutes] <= 11.8)
                                        return 'True'
                                    end
                                end
                                if (data[:total_day_calls] > 96)
                                    return 'True'
                                end
                            end
                        end
                    end
                end
                if (data[:total_eve_charge] > 12.97333)
                    if (data[:total_day_charge] > 29.52125)
                        if (data[:international_plan].nil?)
                            return 'False'
                        end
                        if (data[:international_plan] == 'no')
                            if (data[:total_night_calls].nil?)
                                return 'False'
                            end
                            if (data[:total_night_calls] > 99)
                                if (data[:total_night_charge].nil?)
                                    return 'False'
                                end
                                if (data[:total_night_charge] <= 12.08)
                                    if (data[:total_intl_calls].nil?)
                                        return 'False'
                                    end
                                    if (data[:total_intl_calls] > 3)
                                        return 'False'
                                    end
                                    if (data[:total_intl_calls] <= 3)
                                        if (data[:total_night_charge] <= 9.03)
                                            if (data[:total_night_calls] > 112)
                                                return 'False'
                                            end
                                            if (data[:total_night_calls] <= 112)
                                                if (data[:total_eve_calls].nil?)
                                                    return 'True'
                                                end
                                                if (data[:total_eve_calls] <= 93)
                                                    return 'False'
                                                end
                                                if (data[:total_eve_calls] > 93)
                                                    return 'True'
                                                end
                                            end
                                        end
                                        if (data[:total_night_charge] > 9.03)
                                            return 'False'
                                        end
                                    end
                                end
                                if (data[:total_night_charge] > 12.08)
                                    if (data[:total_intl_minutes].nil?)
                                        return 'True'
                                    end
                                    if (data[:total_intl_minutes] > 8.75)
                                        return 'False'
                                    end
                                    if (data[:total_intl_minutes] <= 8.75)
                                        return 'True'
                                    end
                                end
                            end
                            if (data[:total_night_calls] <= 99)
                                return 'False'
                            end
                        end
                        if (data[:international_plan] == 'yes')
                            if (data[:total_eve_charge] > 20.66)
                                return 'True'
                            end
                            if (data[:total_eve_charge] <= 20.66)
                                if (data[:total_intl_minutes].nil?)
                                    return 'False'
                                end
                                if (data[:total_intl_minutes] <= 12.9)
                                    return 'False'
                                end
                                if (data[:total_intl_minutes] > 12.9)
                                    return 'True'
                                end
                            end
                        end
                    end
                    if (data[:total_day_charge] <= 29.52125)
                        if (data[:total_eve_charge] <= 18)
                            return 'True'
                        end
                        if (data[:total_eve_charge] > 18)
                            return 'False'
                        end
                    end
                end
            end
            if (data[:total_day_minutes] <= 159.7961)
                if (data[:total_eve_minutes].nil?)
                    return 'True'
                end
                if (data[:total_eve_minutes] <= 232.26667)
                    if (data[:total_night_charge].nil?)
                        return 'True'
                    end
                    if (data[:total_night_charge] > 11.215)
                        if (data[:area_code].nil?)
                            return 'True'
                        end
                        if (data[:area_code] == '510')
                            return 'False'
                        end
                        if (data[:area_code] != '510')
                            return 'True'
                        end
                    end
                    if (data[:total_night_charge] <= 11.215)
                        return 'True'
                    end
                end
                if (data[:total_eve_minutes] > 232.26667)
                    if (data[:total_day_charge] > 20.485)
                        if (data[:total_night_charge].nil?)
                            return 'False'
                        end
                        if (data[:total_night_charge] <= 9.33)
                            return 'False'
                        end
                        if (data[:total_night_charge] > 9.33)
                            if (data[:total_night_charge] > 11.4)
                                return 'False'
                            end
                            if (data[:total_night_charge] <= 11.4)
                                if (data[:total_eve_charge].nil?)
                                    return 'True'
                                end
                                if (data[:total_eve_charge] <= 25.165)
                                    return 'True'
                                end
                                if (data[:total_eve_charge] > 25.165)
                                    return 'False'
                                end
                            end
                        end
                    end
                    if (data[:total_day_charge] <= 20.485)
                        return 'True'
                    end
                end
            end
        end
    end
end
end