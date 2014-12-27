package com.lyd.soft.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lyd.soft.dao.IBaseDao;
import com.lyd.soft.pagination.Pagination;
import com.lyd.soft.pagination.PaginationThreadUtils;
import com.lyd.soft.service.IBaseService;
import com.lyd.soft.util.BeanUtils;

@Service
public class BaseServiceImpl<T> implements IBaseService<T> {
	private static final Logger logger = Logger.getLogger(BaseServiceImpl.class);
	
	@Autowired  
    private IBaseDao<T> baseDao;  
	
	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public List<T> getAllList(String tableSimpleName, String[] orderBy, String[] orderType) throws Exception{
		StringBuffer sff = new StringBuffer();  
        sff.append("select a from ").append(tableSimpleName).append(" a "); 
        if(orderBy.length > 0 && orderBy.length == orderType.length){
           sff.append(" order by ");
     	   for(int i = 0; i < orderBy.length; i++){
     		  sff.append("a.").append(orderBy[i]).append(" ").append(orderType);
     		   if(i < orderBy.length-1){
     			  sff.append(", ");
     		   }
     	   }
        }
        List<T> list = this.baseDao.createQuery(sff.toString());  
        return list; 
	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public T getUnique(String tableSimpleName, String[] columns, String[] values) throws Exception{
		StringBuffer sb = new StringBuffer();  
        sb.append("select a from ").append(tableSimpleName).append( " a where ");  
        if(columns.length==values.length){  
            for(int i = 0; i < columns.length; i++){  
                sb.append("a.").append(columns[i]).append("='").append(values[i]).append("'");  
                if(i < columns.length-1){  
                    sb.append(" and ");  
                }  
           }
           T entity = this.baseDao.unique(sb.toString());  
           return entity; 
        }else{  
           logger.error("columns.length != values.length");
           return null;  
        } 
	}
	
	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public List<T> findByWhere(String tableSimpleName, String[] columns,
			String[] values, String[] orderBy, String[] orderType) throws Exception{
		StringBuffer sb = new StringBuffer();  
        sb.append("select a from ").append(tableSimpleName).append( " a where ");  
        if(columns.length==values.length){  
           for(int i = 0; i < columns.length; i++){  
	            sb.append("a.").append(columns[i]).append("='").append(values[i]).append("'");  
	            if(i < columns.length-1){  
	                sb.append(" and ");  
	            }  
           }  
           if(orderBy.length > 0 && orderBy.length == orderType.length){
        	   sb.append(" order by ");
        	   for(int i = 0; i < orderBy.length; i++){
        		   sb.append("a.").append(orderBy[i]).append(" ").append(orderType[i]);
        		   if(i < orderBy.length-1){
        			   sb.append(", ");
        		   }
        	   }
           }
           List<T> list = this.baseDao.createQuery(sb.toString());  
            return list.size()>0?list:null;  
        }else{  
            return null;  
        } 
	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public List<T> getCount(String tableSimpleName) throws Exception{
    	String hql = "select count(*) from " + tableSimpleName;
    	List<T> list = this.baseDao.createQuery(hql);
    	return list;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public Serializable add(T bean) throws Exception{
		return this.baseDao.add(bean);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void saveOrUpdate(T bean) throws Exception{
		this.baseDao.saveOrUpdate(bean);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void delete(T bean) throws Exception{
		this.baseDao.delete(bean);
	}

	@Override
	@Transactional(rollbackFor=Exception.class)
	public void update(T bean) throws Exception{
		this.baseDao.update(bean);
	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public T getBean(Class<T> obj, Serializable id) throws Exception{
		return this.baseDao.getBean(obj, id);
	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public List<T> findByPage(String tableSimpleName, String[] columns, String[] values, String[] orderBy, String[] orderType) throws Exception{
		Pagination pagination = PaginationThreadUtils.get();
		if (pagination == null) {
			pagination = new Pagination();
			PaginationThreadUtils.set(pagination);
			pagination.setCurrentPage(1);
		}
		if (pagination.getTotalSum() == 0) {
			List<T> list = new ArrayList<T>();
			if(columns.length <= 0 && values.length <= 0){
				list = getAllList(tableSimpleName, orderBy, orderType);
			}else{
				list = findByWhere(tableSimpleName, columns, values, orderBy, orderType);
			}
			if(BeanUtils.isBlank(list)){
				pagination.setTotalSum(0);
			}else{
				pagination.setTotalSum(list.size());
			}
		}
		
		int firstResult = (pagination.getCurrentPage() - 1) * pagination.getPageNum();
		int maxResult = pagination.getPageNum();
		//校验分页情况
		if (firstResult >= pagination.getTotalSum() || firstResult < 0) {
			firstResult = 0;
			pagination.setCurrentPage(1);
		}
		//分页处理
		pagination.processTotalPage();
		PaginationThreadUtils.set(pagination);
		StringBuffer sb = new StringBuffer();  
        sb.append("select a from ").append(tableSimpleName).append( " a where ");  
        if(columns.length==values.length){  
            for(int i = 0; i < columns.length; i++){  
                sb.append("a.").append(columns[i]).append("='").append(values[i]).append("'");  
                if(i < columns.length-1){  
                    sb.append(" and ");  
                }  
           } 
	       String hql = sb.toString();
	       if(hql.endsWith("where ")){
	    	   hql = hql.substring(0, hql.length()-6);
	       }
	       logger.info("findByPage: HQL: "+hql);
	       List<T> list = this.baseDao.findByPage(hql, firstResult, maxResult); 
	       return list.size()>0?list:null;
        }else{
        	logger.info("findByPage: columns.length != values.length");
        	return null;
        }
	}

	/**
	 * 固定参数 columns 和 values 
	 * columns[]{"teacher", "beginDate"}
	 * values[]{teacher_id, beginDate, endDate}
	 */
	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public List<T> getRangeDate(String tableSimpleName, String[] columns,
			String[] values) throws Exception {
    	StringBuffer sb = new StringBuffer();  
        sb.append("select a from ").append(tableSimpleName).append( " a where a.").append(columns[0]); 
        sb.append("='").append(values[0]).append("'").append(" and a.").append(columns[1]); 
        sb.append(" BETWEEN '").append(values[1]).append("' and '").append(values[2]).append("'");
        String sub = sb.toString();
        List<T> list = this.baseDao.createQuery(sub);
        return list.size()>0?list:null;
	}

}
