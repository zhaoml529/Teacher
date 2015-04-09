package com.lyd.soft.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;

/**
 * 教师基本档案表（教师自己添加，系部管理员审核）
 * @author LYD
 *
 */

@Entity
@Table(name = "T_TEACHER_ARCHIVE")
public class TeacherArchive implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8641492872316800942L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID", unique = true, nullable = false)
	private Integer id;			
	
	@OneToOne
	@JoinColumn(name="TEACHER_ID",nullable = false)
	private Teacher teacher;		//教师编号

	@Column(name = "ARCHIVE_NUMBER")
	private String archiveNumber;	//档案编号
	
	@Column(name = "TEACHER_NAME")
	private String teacherName;		//教师姓名
	
	@Column(name = "TEACHER_PICTURE")
	private String teacherPic;		//照片
	
	//统计
	@Column(name = "SEX")
	@NotNull(message = "{ta.sex.not.empty}")
	private Integer sex;			//0.female女 1.male  男
	
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name = "BIRTHDAY")
	@NotNull(message="{ta.birthday.not.empty}")
	private Date birthday;			//出生日期
	
	@Column(name = "NATIVE_PLACE")
	@NotEmpty(message="{ta.nativePlace.not.empty}")
	private String nativePlace;		//籍贯
	
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name = "WORK_DATE")
	@NotNull(message="{ta.workDate.not.empty}")
	private Date workDate;			//参加工作时间
	
	@Column(name = "ID_NUMBER")
	@NotEmpty(message="{ta.IDNumber.not.empty}")
	@Length(max = 18, message = "{ta.IDNumber.length.illegal}")
	private String IDNumber;		//身份证号码
	
	@Column(name = "POLITICL_STATUS")
	@NotEmpty(message="{ta.politicalStatus.not.empty}")
	private String politicalStatus;	//政治面貌
	
	@Column(name = "PHONE_NUMBER")
	@NotEmpty(message="{ta.phoneNumber.not.empty}")
	private String phoneNumber;		//联系电话
	
	@Column(name = "EMAIL")
	@Email(message = "邮箱格式不正确！")
	@NotEmpty(message="{ta.email.not.empty}")
	private String email;			//个人邮箱
	
	@Column(name = "EDUCATION1")
	@NotEmpty(message="{ta.education1.not.empty}")
	private String education1;		//第一学历
	
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name = "GET_EDUCATION1")
	@NotNull(message="{ta.getEducation1.not.empty}")
	private Date getEducation1;		//第一学历取得时间
	
	@Column(name = "GRADUATE_SCHOOL1")
	@NotEmpty(message="{ta.graSchool1.not.empty}")
	private String graSchool1;		//第一学历毕业院校graduateSchool
	
	@Column(name = "EDUCATION2")
	@NotEmpty(message="{ta.education2.not.empty}")
	private String education2;		//第二学历
	
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name = "GET_EDUCATION2")
	@NotNull(message="{ta.getEducation2.not.empty}")
	private Date getEducation2;		//第二学历取得时间
	
	@Column(name = "GRADUATE_SCHOOL2")
	@NotEmpty(message="{ta.graSchool2.not.empty}")
	private String graSchool2;		//第二学历毕业院校graduateSchool
	
	//统计 1.学士 2.硕士 3.博士 4.专科 5.其他
	@Column(name = "DEGREE")
	@NotEmpty(message="{ta.degree.not.empty}")
	private String degree;			//最高学位
	
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name = "GET_DEGREE")
	@NotNull(message="{ta.getDegree.not.empty}")
	private Date getDegree;			//学位取得时间
	
	@Column(name = "PROFESSION_AREA")
	@NotEmpty(message="{ta.professionArea.not.empty}")
	private String professionArea;	//专业领域
	
	//统计1.一级甲等2.一级乙等3.二级甲等4.二级乙等5.三级甲等6.三级乙等
	@Column(name = "MANDARIN_LEVEL")
	@NotEmpty(message="{ta.mandarinLevel.not.empty}")
	private String mandarinLevel;	//普通话水平
	
	//统计  1.教授 2.副教授 3.讲 师 4.助理讲师
	@Column(name = "TECHNICAL_POSITION")
	@NotEmpty(message="{ta.technicalPosition.not.empty}")
	private String technicalPosition;		//技术职务等级
	
	//1.是  0.否
	@Column(name = "IS_DOUBLE_TEACHERS")
	@NotNull(message="{ta.isDoubleTeachers.not.empty}")
	private Integer isDoubleTeachers;		//是否为双师型教师
	
	@Column(name = "IS_BACKBONE")
	@NotNull(message="{ta.isBackbone.not.empty}")
	private Integer isBackbone;				//是否为骨干教师
	
	@Column(name = "IS_SUBJECT_LEADER")
	@NotNull(message="{ta.isSubjectLeader.not.empty}")
	private Integer isSubjectLeader;		//是否为学科带头人
	
	@Column(name = "EVIDENCE_NUMBER")
	@NotEmpty(message="{ta.evidenceNumber.not.empty}")
	private String evidenceNumber;			//佐证证件及编号
	
	@Column(name = "REMARK")
	private String remark;					//备注
	
	@Column(name = "IS_PASS")
	private String isPass;					//系部管理员审核

	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy-MM-dd hh:mm")
	@Column(name = "CREATE_DATE")
	private Date createDate;				//档案创建时间
	
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy-MM-dd hh:mm")
	@Column(name = "UPDATE_DATE")
	private Date updateDate;				//档案修改时间
	
	@OneToOne
	@JoinColumn(name="UPDATE_USER_ID")
	private Teacher updateUser;				//最后一次修改人
	
	@Column(name = "IS_DELETE")
	private Integer isDelete;		//删除
	

	public Integer getId() {
		return id;
	}


	public void setId(Integer id) {
		this.id = id;
	}

	public String getArchiveNumber() {
		return archiveNumber;
	}


	public void setArchiveNumber(String archiveNumber) {
		this.archiveNumber = archiveNumber;
	}


	public String getTeacherName() {
		return teacherName;
	}


	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}


	public Integer getSex() {
		return sex;
	}


	public void setSex(Integer sex) {
		this.sex = sex;
	}


	public Date getBirthday() {
		return birthday;
	}


	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}


	public String getNativePlace() {
		return nativePlace;
	}


	public void setNativePlace(String nativePlace) {
		this.nativePlace = nativePlace;
	}


	public Date getWorkDate() {
		return workDate;
	}


	public void setWorkDate(Date workDate) {
		this.workDate = workDate;
	}


	public String getIDNumber() {
		return IDNumber;
	}


	public void setIDNumber(String iDNumber) {
		IDNumber = iDNumber;
	}


	public String getPoliticalStatus() {
		return politicalStatus;
	}


	public void setPoliticalStatus(String politicalStatus) {
		this.politicalStatus = politicalStatus;
	}


	public String getPhoneNumber() {
		return phoneNumber;
	}


	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getEducation1() {
		return education1;
	}


	public void setEducation1(String education1) {
		this.education1 = education1;
	}


	public Date getGetEducation1() {
		return getEducation1;
	}


	public void setGetEducation1(Date getEducation1) {
		this.getEducation1 = getEducation1;
	}


	public String getGraSchool1() {
		return graSchool1;
	}


	public void setGraSchool1(String graSchool1) {
		this.graSchool1 = graSchool1;
	}


	public String getEducation2() {
		return education2;
	}


	public void setEducation2(String education2) {
		this.education2 = education2;
	}


	public Date getGetEducation2() {
		return getEducation2;
	}


	public void setGetEducation2(Date getEducation2) {
		this.getEducation2 = getEducation2;
	}


	public String getGraSchool2() {
		return graSchool2;
	}


	public void setGraSchool2(String graSchool2) {
		this.graSchool2 = graSchool2;
	}


	public String getDegree() {
		return degree;
	}


	public void setDegree(String degree) {
		this.degree = degree;
	}


	public Date getGetDegree() {
		return getDegree;
	}


	public void setGetDegree(Date getDegree) {
		this.getDegree = getDegree;
	}


	public String getProfessionArea() {
		return professionArea;
	}


	public void setProfessionArea(String professionArea) {
		this.professionArea = professionArea;
	}


	public String getMandarinLevel() {
		return mandarinLevel;
	}


	public void setMandarinLevel(String mandarinLevel) {
		this.mandarinLevel = mandarinLevel;
	}


	public String getTechnicalPosition() {
		return technicalPosition;
	}


	public void setTechnicalPosition(String technicalPosition) {
		this.technicalPosition = technicalPosition;
	}


	public Integer getIsDoubleTeachers() {
		return isDoubleTeachers;
	}


	public void setIsDoubleTeachers(Integer isDoubleTeachers) {
		this.isDoubleTeachers = isDoubleTeachers;
	}


	public Integer getIsBackbone() {
		return isBackbone;
	}


	public void setIsBackbone(Integer isBackbone) {
		this.isBackbone = isBackbone;
	}


	public Integer getIsSubjectLeader() {
		return isSubjectLeader;
	}


	public void setIsSubjectLeader(Integer isSubjectLeader) {
		this.isSubjectLeader = isSubjectLeader;
	}


	public String getEvidenceNumber() {
		return evidenceNumber;
	}


	public void setEvidenceNumber(String evidenceNumber) {
		this.evidenceNumber = evidenceNumber;
	}


	public Integer getIsDelete() {
		return isDelete;
	}


	public void setIsDelete(Integer isDelete) {
		this.isDelete = isDelete;
	}

	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}


	public Teacher getTeacher() {
		return teacher;
	}


	public void setTeacher(Teacher teacher) {
		this.teacher = teacher;
	}


	public Date getCreateDate() {
		return createDate;
	}


	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}


	public Date getUpdateDate() {
		return updateDate;
	}


	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}


	public Teacher getUpdateUser() {
		return updateUser;
	}


	public void setUpdateUser(Teacher updateUser) {
		this.updateUser = updateUser;
	}


	public String getTeacherPic() {
		return teacherPic;
	}


	public void setTeacherPic(String teacherPic) {
		this.teacherPic = teacherPic;
	}


	public String getRemark() {
		return remark;
	}


	public void setRemark(String remark) {
		this.remark = remark;
	}


	public String getIsPass() {
		return isPass;
	}


	public void setIsPass(String isPass) {
		this.isPass = isPass;
	}

	
}
