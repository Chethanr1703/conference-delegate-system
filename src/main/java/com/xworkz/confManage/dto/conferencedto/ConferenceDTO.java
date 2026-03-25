package com.xworkz.confManage.dto.conferencedto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.*;
import java.time.LocalDate;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class ConferenceDTO {

    private int id;

    @NotNull(message = "Host name is required")
    @Size(min = 3, max = 40, message = "Host name must be between 3 and 40 characters")
    @Pattern(regexp = "^[A-Za-z ]+$", message = "Host name must contain only letters")
    private String hostName;
    @NotNull(message =" Email is required")
    @Pattern(regexp = "^[a-zA-Z0-9._%+-]+@gmail\\.com$",message = "email is not valid")
    private String email;

    @NotNull(message =" delegatesEmail is required")
    @Pattern(regexp = "^[a-zA-Z0-9._%+-]+@gmail\\.com$",message = "delegatesEmail is not valid")
    private String delegatesEmail;

    @NotNull(message = "Conference topic is required")
    @Size(min = 5, max = 100, message = "Conference topic must be between 5 and 100 characters")
    private String conferenceTopic;

    @NotNull(message = "Targeted audience is required")
    @Size(min = 3, max = 50, message = "Targeted audience must be between 3 and 50 characters")
    private String targetedAudience;

    @NotNull
    @FutureOrPresent
    @DateTimeFormat(pattern = "yyyy-MM-dd")   //  IMPORTANT
    private LocalDate date;

    @NotNull(message = "Time is required")
    @Pattern(
            regexp = "^(0[1-9]|1[0-2]):([0-5][0-9])\\s?(AM|PM)$",
            message = "Time must be in hh:mm AM/PM format"
    )
    private String time;
    private  boolean active;
    private boolean emailSent;

    private MultipartFile poster;        // image
    private MultipartFile delegateFile;
}