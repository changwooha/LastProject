package com.example.dto;

public class OrderDetail {

	private int odtNo;
	private int odtQuantity;
	private String prdCode;
	private int ordNo;
	private String mbrId;
	private int odtCheck;
	private int odtType;
	
	
	private String prdName; // 오더조회용
	private String prdSize;
	private int PrdPrice;
	private int PrdQuantity;
	private int PrdInstallTime;
	
	
	public int getOdtNo() {
		return odtNo;
	}
	public void setOdtNo(int odtNo) {
		this.odtNo = odtNo;
	}
	public int getOdtQuantity() {
		return odtQuantity;
	}
	public void setOdtQuantity(int odtQuantity) {
		this.odtQuantity = odtQuantity;
	}
	public String getPrdCode() {
		return prdCode;
	}
	public void setPrdCode(String prdCode) {
		this.prdCode = prdCode;
	}
	public int getOrdNo() {
		return ordNo;
	}
	public void setOrdNo(int ordNo) {
		this.ordNo = ordNo;
	}
	public String getMbrId() {
		return mbrId;
	}
	public void setMbrId(String mbrId) {
		this.mbrId = mbrId;
	}
	public int getOdtCheck() {
		return odtCheck;
	}
	public void setOdtCheck(int odtCheck) {
		this.odtCheck = odtCheck;
	}
	public int getOdtType() {
		return odtType;
	}
	public void setOdtType(int odtType) {
		this.odtType = odtType;
	}
	public String getPrdName() {
		return prdName;
	}
	public void setPrdName(String prdName) {
		this.prdName = prdName;
	}
	public String getPrdSize() {
		return prdSize;
	}
	public void setPrdSize(String prdSize) {
		this.prdSize = prdSize;
	}
	public int getPrdPrice() {
		return PrdPrice;
	}
	public void setPrdPrice(int prdPrice) {
		PrdPrice = prdPrice;
	}
	public int getPrdQuantity() {
		return PrdQuantity;
	}
	public void setPrdQuantity(int prdQuantity) {
		PrdQuantity = prdQuantity;
	}
	public int getPrdInstallTime() {
		return PrdInstallTime;
	}
	public void setPrdInstallTime(int prdInstallTime) {
		PrdInstallTime = prdInstallTime;
	}
	

}
