package pojo;

import DAO.ScheduleDAO;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.event.AjaxBehaviorEvent;

@ManagedBean
@ViewScoped
public class Schedule implements java.io.Serializable {

    private Integer id;
    private String time;
    private String services;
    private String searchCriteria;  // For the search filter
    private List<Schedule> scheduleList;
    private ScheduleDAO scheduleDAO = new ScheduleDAO();

    public Schedule() {}

    public Schedule(String time, String services) {
        this.time = time;
        this.services = services;
    }
    
    @PostConstruct
    public void init() {
        if (id != null) {
            List<Schedule> scheduleData = scheduleDAO.getByID(id);
            if (scheduleData != null && !scheduleData.isEmpty()) {
                Schedule sched = scheduleData.get(0);
                this.time = sched.getTime();        // Set waktu dari data database
                this.services = sched.getServices(); // Set layanan dari data database
            }
        }
    }

    // Getters and Setters
    public Integer getId() { return this.id; }
    public void setId(Integer id) { this.id = id; }
    public String getTime() { return this.time; }
    public void setTime(String time) { this.time = time; }
    public String getServices() { return this.services; }
    public void setServices(String services) { this.services = services; }

    public String getSearchCriteria() { return searchCriteria; }
    public void setSearchCriteria(String searchCriteria) { this.searchCriteria = searchCriteria; }

    public List<Schedule> getScheduleList() {
        if (scheduleList == null || searchCriteria == null || searchCriteria.isEmpty()) {
            scheduleList = scheduleDAO.retrieveTblSchedules();
        }
        return scheduleList;
    }

    public void filterSchedules(AjaxBehaviorEvent event) {
        if (searchCriteria != null && !searchCriteria.isEmpty()) {
            scheduleList = scheduleDAO.searchSchedule(searchCriteria, null, null);
        } else {
            scheduleList = scheduleDAO.retrieveTblSchedules();
        }
    }

    
    
    public String saveSchedule() {
        scheduleDAO.addSchedule(this);
        return "scheduledetail";
    }

    public String editSchedule() {
        Schedule schedule = new Schedule(); // Create new schedule object
        schedule.setId(this.id);            // Set the ID from the current bean
        schedule.setTime(this.time);        // Set time from the form
        schedule.setServices(this.services);// Set services from the form

        scheduleDAO.editSchedule(schedule); // Call DAO to save changes
        return "scheduledetail.xhtml?faces-redirect=true"; // Redirect to detail page after saving
    }

    // Method untuk menghapus jadwal
    public String deleteSchedule() {
    if (this.id != null) {
        ScheduleDAO scheduleDAO = new ScheduleDAO();
        scheduleDAO.deleteSchedule(this.id); // Call DAO to delete schedule by ID
    }
    return null; // Stay on the same page after deletion
}


    public String getById(int scheduleId) {
        List<Schedule> scheduleData = scheduleDAO.getByID(scheduleId);
        if (scheduleData != null && !scheduleData.isEmpty()) {
            this.id = scheduleData.get(0).getId();
            this.time = scheduleData.get(0).getTime();
            this.services = scheduleData.get(0).getServices();
            return "scheduleedit";
        }
        return "index";
    }
    
    public void loadSchedule() {
        if (id != null) {
            List<Schedule> scheduleList = scheduleDAO.getByID(id);
            if (scheduleList != null && !scheduleList.isEmpty()) {
                Schedule sched = scheduleList.get(0);
                this.time = sched.getTime(); // Load time from DB
                this.services = sched.getServices(); // Load services from DB
            }
        }
    }
}
