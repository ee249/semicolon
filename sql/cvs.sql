CREATE TABLE CVSINFO_TB
(
    id       INT              NOT NULL, 
    brand    VARCHAR2(300)    NOT NULL, 
    CONSTRAINT CVSINFO_TB_PK PRIMARY KEY (id)
)
/
------------------------------------------------------
CREATE TABLE CVS_TB
(
    no      INT              NOT NULL, 
    id      INT              NOT NULL, 
    name    VARCHAR2(300)    NULL, 
    addr    VARCHAR2(900)    NULL, 
    lat     NUMBER           NULL, 
    lng     NUMBER           NULL, 
    CONSTRAINT CVS_TB_PK PRIMARY KEY (no)
)
/

CREATE SEQUENCE CVS_TB_SEQ
START WITH 1
INCREMENT BY 1;
/

CREATE OR REPLACE TRIGGER CVS_TB_AI_TRG
BEFORE INSERT ON CVS_TB 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT CVS_TB_SEQ.NEXTVAL
    INTO :NEW.no
    FROM DUAL;
END;
/

--DROP TRIGGER CVS_TB_AI_TRG;
/

--DROP SEQUENCE CVS_TB_SEQ;
/

ALTER TABLE CVS_TB
    ADD CONSTRAINT FK_CVS_TB_id_CVSINFO_TB_id FOREIGN KEY (id)
        REFERENCES CVSINFO_TB (id)
/
------------------------------------------
desc cvs_tb;

select * from cvsinfo_tb;
select count(*) from cvs_tb;

drop table cvs_tb;
/
DROP TRIGGER CVS_TB_AI_TRG;
/

DROP SEQUENCE CVS_TB_SEQ;
/


----------------------------------------------------

select * from cvs_tb;