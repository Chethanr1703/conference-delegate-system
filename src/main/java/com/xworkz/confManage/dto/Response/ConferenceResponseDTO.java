package com.xworkz.confManage.dto.Response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ConferenceResponseDTO {
    private int id;
    private String hostName;
    private String email;
    private String conferenceTopic;
    private String targetedAudience;
    private String date;
    private String time;
    private boolean active;
    private boolean emailSent;
}