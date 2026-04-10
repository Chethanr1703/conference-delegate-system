package com.xworkz.confManage.utils;

import org.springframework.stereotype.Component;

import java.util.regex.Pattern;
@Component
public class ParticipantsValidator {

        private static final Pattern EMAIL_PATTERN =
                Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");

        private static final Pattern MOBILE_PATTERN =
                Pattern.compile("\\d{10}");

        public static boolean validName(String name){
            return name != null && name.trim().matches("^[A-Za-z. ]+$");
        }

        public static boolean validEmail(String email){
            return email != null &&
                    EMAIL_PATTERN.matcher(email).matches();
        }

        public static boolean validMobile(String mobile){
            return mobile != null &&
                    MOBILE_PATTERN.matcher(mobile).matches();
        }

        public static boolean validOrganization(String org){
            return org != null && !org.trim().isEmpty();
        }

        public static boolean validAttending(String attending){
            return attending != null &&
                    (attending.equalsIgnoreCase("YES")
                            || attending.equalsIgnoreCase("NO"));
        }
    }
