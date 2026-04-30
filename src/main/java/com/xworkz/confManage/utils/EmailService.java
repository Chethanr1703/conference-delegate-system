package com.xworkz.confManage.utils;

import com.sendgrid.Method;
import com.sendgrid.Request;
import com.sendgrid.Response;
import com.sendgrid.SendGrid;
import com.sendgrid.helpers.mail.Mail;
import com.sendgrid.helpers.mail.objects.Attachments;
import com.sendgrid.helpers.mail.objects.Content;
import com.sendgrid.helpers.mail.objects.Email;
import com.xworkz.confManage.entity.conference.ConferenceEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import javax.mail.internet.MimeMessage;
import java.util.Base64;
import java.util.Random;

@Component
public class EmailService {
    @Autowired
    private JavaMailSender emailSender;

    public String generateOtp() {
        return String.valueOf(100000 + new Random().nextInt(900000));
    }


    public void sendHtmlMail(String to, String subject, String htmlBody, ConferenceEntity conf) {

        try {

            Email from = new Email("chethanbabu1708@gmail.com"); // must be verified in SendGrid
            Email toEmail = new Email(to);

            Content content = new Content("text/html", htmlBody);

            Mail mail = new Mail(from, subject, toEmail, content);

            //  KEEP YOUR EXISTING IMAGE LOGIC (converted for SendGrid)
            byte[] posterBytes = conf.getPoster();

            if (posterBytes != null && posterBytes.length > 0) {

                Attachments attachment = new Attachments();

                String base64 = Base64.getEncoder().encodeToString(posterBytes);

                attachment.setContent(base64);
                attachment.setType("image/png");
                attachment.setFilename("poster.png");

                // 👇 SAME cid mapping
                attachment.setDisposition("inline");
                attachment.setContentId("posterImage");

                mail.addAttachments(attachment);

            } else {
                System.out.println("Poster is NULL");
            }

            SendGrid sg = new SendGrid("0c549bb1-780e-499b-a46c-a4a2d12917de");

            Request request = new Request();
            request.setMethod(Method.POST);
            request.setEndpoint("mail/send");
            request.setBody(mail.build());

            Response response = sg.api(request);

            System.out.println("SendGrid Status: " + response.getStatusCode());

        } catch (Exception e) {
            System.out.println("Mail failed: " + e.getMessage());
            e.printStackTrace();
        }

    }
}
