package com.ncu.webchat.pojo;

import org.springframework.stereotype.Repository;

@Repository(value = "ChatRecord")
public class ChatRecord {
    private String firstperson;

    private String secondperson;

    private String content;

    private String state;

    private  String time;

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getFirstperson() {
        return firstperson;
    }

    public void setFirstperson(String firstperson) {
        this.firstperson = firstperson;
    }

    public String getSecondperson() {
        return secondperson;
    }

    public void setSecondperson(String secondperson) {
        this.secondperson = secondperson;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }
}
