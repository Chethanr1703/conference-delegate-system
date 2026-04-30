package com.xworkz.confManage.utils;

import com.xworkz.confManage.entity.conference.ConferenceEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import javax.mail.internet.MimeMessage;
import java.util.Random;

@Component
public class EmailService {
    @Autowired
    private JavaMailSender emailSender;

    public String generateOtp() {
        return String.valueOf(100000 + new Random().nextInt(900000));
    }

//    public void sendSimpleMessage(
//            String to, String subject, String text) {
//
//        SimpleMailMessage message = new SimpleMailMessage();
//        message.setFrom("chethanbabu1708@gmail.com");  // two step verified email
//        message.setTo(to);
//        message.setSubject(subject);
//        message.setText(text);
//        emailSender.send(message);
//    }

    public void sendHtmlMail(String to, String subject, String htmlBody, ConferenceEntity conf) {

        MimeMessage message = emailSender.createMimeMessage();

        try {
            MimeMessageHelper helper =
                    new MimeMessageHelper(message, true, "UTF-8");

            helper.setFrom("chethanbabu1708@gmail.com");
            helper.setTo(to);
            helper.setSubject(subject);
            helper.setText(htmlBody, true); // true = HTML

            byte[] posterBytes = conf.getPoster();

            if (posterBytes != null && posterBytes.length > 0) {

                ByteArrayResource resource =
                        new ByteArrayResource(posterBytes);

                helper.addInline("posterImage", resource, "image/png");
            }else {
                System.out.println(" Poster is NULL");
            }

            emailSender.send(message);

        } catch (Exception e) {
            System.out.println("Mail failed: " + e.getMessage());
            e.printStackTrace();
        }
    }

}
