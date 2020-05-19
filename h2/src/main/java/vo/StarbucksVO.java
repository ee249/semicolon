package vo;

//starbucks 
public class StarbucksVO {
	
    // storeId 
    private Integer storeid;

    // storeName 
    private String storename;

    // storeAddr 
    private String storeaddr;

    // storeLat 
    private double storelat;

    // storeLng 
    private double storelng;

    public Integer getStoreid() {
        return storeid;
    }

    public void setStoreid(Integer storeid) {
        this.storeid = storeid;
    }

    public String getStorename() {
        return storename;
    }

    public void setStorename(String storename) {
        this.storename = storename;
    }

    public String getStoreaddr() {
        return storeaddr;
    }

    public void setStoreaddr(String storeaddr) {
        this.storeaddr = storeaddr;
    }

    public double getStorelat() {
        return storelat;
    }

    public void setStorelat(double storelat) {
        this.storelat = storelat;
    }

    public double getStorelng() {
        return storelng;
    }

    public void setStorelng(double storelng) {
        this.storelng = storelng;
    }
    
	@Override
	public String toString() {
		return "StarbucksVO [storeid=" + storeid + ", storename=" + storename + ", storeaddr=" + storeaddr
				+ ", storelat=" + storelat + ", storelng=" + storelng + "]";
	}

}
