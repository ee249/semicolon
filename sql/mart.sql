CREATE TABLE MARTINFO_TB
(
    id       INT              NOT NULL, 
    brand    VARCHAR2(300)    NOT NULL, 
    CONSTRAINT MARTINFO_TB_PK PRIMARY KEY (id)
)

-----------------------------------------------------------

CREATE TABLE MART_TB
(
    no      INT              NOT NULL, 
    id      INT              NOT NULL, 
    name    VARCHAR2(300)    NULL, 
    addr    VARCHAR2(900)    NULL, 
    lat     NUMBER           NULL, 
    lng     NUMBER           NULL, 
    CONSTRAINT MART_TB_PK PRIMARY KEY (no)
);


CREATE SEQUENCE MART_TB_SEQ
START WITH 1
INCREMENT BY 1;
CREATE OR REPLACE TRIGGER MART_TB_AI_TRG
BEFORE INSERT ON MART_TB 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT MART_TB_SEQ.NEXTVAL
    INTO :NEW.no
    FROM DUAL;
END;

--DROP TRIGGER MART_TB_AI_TRG;
--DROP SEQUENCE MART_TB_SEQ;


ALTER TABLE MART_TB
    ADD CONSTRAINT FK_MART_TB_id_MARTINFO_TB_id FOREIGN KEY (id)
        REFERENCES MARTINFO_TB (id);
        
/        
select count(*) from mart_tb;